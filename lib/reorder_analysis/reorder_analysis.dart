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
import 'reorder_analysis_input.dart';

FutureOr<Uint8List> reorderAnalysis(ReorderAnalysis data) {
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
      footer: (context) => buildPageFooter(context),
      build: (context) {
        return [
          buildReportHeader(
            orgName: data.orgName,
            branchInfo: data.branchInfo,
            title: data.title,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: buildFilterRow(key: "Branch", value: data.branches),
          ),
          buildDivider(),
          pw.SizedBox(height: 8),
          for (final record in data.records.entries) ...[
            pw.Text(
              (data.group == "vendor")
                  ? 'Supplier: ${record.key}'
                  : 'Manufacturer: ${record.key}',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey800),
              columnWidths: {
                0: const pw.FlexColumnWidth(5),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
                3: const pw.FlexColumnWidth(2),
                4: const pw.FlexColumnWidth(2),
              },
              children: [
                pw.TableRow(
                  children: [
                    buildTableCell(
                      isHeader: true,
                      value: "Item",
                    ),
                    buildTableCell(
                      isHeader: true,
                      value: "Order Level",
                      alignment: pw.Alignment.center,
                    ),
                    buildTableCell(
                      isHeader: true,
                      value: "Stock",
                      alignment: pw.Alignment.center,
                    ),
                    buildTableCell(
                      isHeader: true,
                      value: "Order Qty",
                      alignment: pw.Alignment.center,
                    ),
                    buildTableCell(
                      isHeader: true,
                      value: "Unit",
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
                for (final value in record.value)
                  pw.TableRow(
                    children: [
                      buildTableCell(
                        value: value.inventory,
                      ),
                      buildTableCell(
                        value: value.orderLevel.toString(),
                        alignment: pw.Alignment.center,
                      ),
                      buildTableCell(
                        value: value.orderQty.toString(),
                        alignment: pw.Alignment.center,
                      ),
                      buildTableCell(
                        value: value.stock.toString(),
                        alignment: pw.Alignment.center,
                      ),
                      buildTableCell(
                        value: value.unit,
                        alignment: pw.Alignment.centerRight,
                      ),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 8),
          ]
        ];
      },
    ),
  );

  return pdf.save();
}
