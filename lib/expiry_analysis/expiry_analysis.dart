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
import 'expiry_analysis_input.dart';

FutureOr<Uint8List> expiryAnalysis(ExpiryAnalysisInput data) async {
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
            title: "Expiry Analysis",
            fromDate: data.fromDate,
            toDate: data.toDate,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: buildFilterRow(key: "Branch", value: data.branches),
          ),
          buildDivider(),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Expiry",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Particulars",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Batch No.",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Stock",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "value",
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
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(6),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FlexColumnWidth(2),
            },
            children: [
              for (final data in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(value: data.expiry),
                    buildTableCell(value: data.particulars),
                    buildTableCell(value: data.batchNo ?? ''),
                    buildTableCell(
                      value: data.closing.toString(),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: data.assetValue.toStringAsFixed(2),
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
                        "Total Value : Rs. ${data.summary.assetValue.toStringAsFixed(2)}",
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
