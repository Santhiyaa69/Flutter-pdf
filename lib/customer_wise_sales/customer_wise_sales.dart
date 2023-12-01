import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../common/divider.dart';
import '../common/filter_row.dart';
import '../common/page_footer.dart';
import '../common/report_header.dart';
import '../common/table_cell.dart';
import '../main.dart';
import 'customer_wise_sales_input.dart';

FutureOr<Uint8List> customerWiseSales(CustomerWiseSalesInput data) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.courier();
  final bold = pw.Font.courierBold();
  final pageFormat = PdfPageFormat(mm(210), mm(297), marginAll: mm(10));

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat,
        theme: pw.ThemeData.withFont(base: font, bold: bold),
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
                buildFilterRow(key: "Branch", value: data.branches),
                if (data.customers != null)
                  buildFilterRow(key: "Customer", value: data.customers!),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Name",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Mobile",
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
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(1.5),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(value: record.name),
                    buildTableCell(value: record.mobile ?? ''),
                    buildTableCell(
                      value: record.total >= 0
                          ? '${record.total.toString()} Dr'
                          : '${record.total.abs().toString()} Cr',
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          buildFilterRow(
            key: "Total",
            value: data.total >= 0
                ? '${data.total.toString()} Dr'
                : '${data.total.abs().toString()} Cr',
            keyWidth: 40,
            mainAxisalignment: pw.MainAxisAlignment.end,
          ),
          buildDivider(),
        ];
      },
    ),
  );
  return pdf.save();
}
