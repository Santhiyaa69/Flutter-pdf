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
import 'stock_analysis_input.dart';

FutureOr<Uint8List> stockAnalysis(StockAnalysisInput data) async {
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
            asOnDate: data.asOnDate,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Column(
              children: [
                buildFilterRow(
                  key: "Branch",
                  value: data.branches,
                  keyWidth: 180,
                ),
                buildFilterRow(
                  key: "Group By",
                  value: data.group,
                  keyWidth: 180,
                ),
                buildFilterRow(
                  key: "Stock value calculated by",
                  value: "Average Cost",
                  keyWidth: 180,
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(7),
              2: const pw.FlexColumnWidth(3),
              3: const pw.FlexColumnWidth(3),
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
                    value: data.group,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Stock",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Value",
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
              1: const pw.FlexColumnWidth(7),
              2: const pw.FlexColumnWidth(3),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              for (final (idx, data) in data.records.indexed)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      value: (idx + 1).toString(),
                    ),
                    buildTableCell(
                      value: data.name ?? 'Not Available',
                    ),
                    buildTableCell(
                      value: data.closing.toString(),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: data.value.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          pw.Table(
            columnWidths: {
              0: const pw.FixedColumnWidth(1),
              1: const pw.FixedColumnWidth(1),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Total Stock : ${data.summary.closing.toString()}",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value:
                        "Total Value : Rs. ${data.summary.value.toStringAsFixed(2)}",
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
