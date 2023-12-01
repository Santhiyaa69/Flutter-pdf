import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/divider.dart';
import '../common/filter_row.dart';
import '../common/page_footer.dart';
import '../common/report_header.dart';
import '../common/table_cell.dart';
import '../main.dart';
import 'sales_by_incharge_input.dart';

FutureOr<Uint8List> salesByIncharge(SalesByInchargeInput data) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.courier();
  final bold = pw.Font.courierBold();
  final pageFormat = PdfPageFormat(mm(210), mm(297), marginAll: mm(10));

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: font, bold: bold),
        pageFormat: pageFormat,
      ),
      footer: (context) {
        return buildPageFooter(context);
      },
      build: (context) {
        return [
          buildReportHeader(
            orgName: data.orgName,
            branchInfo: data.branchInfo,
            title: data.title,
            fromDate: data.fromDate,
            toDate: data.toDate,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Column(
              children: [
                buildFilterRow(
                  key: "Branch",
                  value: data.branches,
                ),
                if (data.salesIncharges != null)
                  buildFilterRow(
                    key: "Sale Incharges",
                    value: data.salesIncharges!,
                  ),
                if (data.customerGroups != null)
                  buildFilterRow(
                    key: "Customer Groups",
                    value: data.customerGroups!,
                  ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(5),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
              4: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "S.No",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Name",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Code",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Taxable Amount",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Amount",
                    alignment: pw.Alignment.centerRight,
                  ),
                ],
              ),
            ],
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey800),
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(5),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
              4: const pw.FlexColumnWidth(3),
            },
            children: [
              for (final (idx, data) in data.records.indexed)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      value: (idx + 1).toString(),
                    ),
                    buildTableCell(
                      value: data.name,
                    ),
                    buildTableCell(
                      value: data.code,
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: data.taxableAmount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: data.amount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          pw.Table(
            columnWidths: {
              0: const pw.FixedColumnWidth(2.6),
              1: const pw.FixedColumnWidth(1),
              2: const pw.FixedColumnWidth(1),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Total",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: data.summary.taxableAmount.toStringAsFixed(2),
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: data.summary.amount.toStringAsFixed(2),
                    alignment: pw.Alignment.centerRight,
                  ),
                ],
              ),
            ],
          ),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}
