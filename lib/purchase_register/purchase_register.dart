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
import 'purchase_register_footer.dart';
import 'purchase_register_input.dart';

FutureOr<Uint8List> purchaseRegisterGroupView(
  PurchaseRegisterInput data,
) {
  final pdf = pw.Document();
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
                if (data.vendor != null)
                  buildFilterRow(
                    key: "Vendor",
                    value: data.vendor!,
                  ),
                if (data.paymentAccounts != null)
                  buildFilterRow(
                    key: "Account",
                    value: data.paymentAccounts!,
                  ),
                buildFilterRow(
                  key: "Payment Mode",
                  value: data.paymentMode ?? "All",
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            columnWidths: (data.group != null)
                ? {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(4),
                    2: const pw.FlexColumnWidth(3),
                  }
                : {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(1),
                  },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Particulars",
                  ),
                  if (data.group != null)
                    buildTableCell(
                      isHeader: true,
                      value: "Branch",
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
            columnWidths: (data.group != null)
                ? {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(4),
                    2: const pw.FlexColumnWidth(3),
                  }
                : {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(1),
                  },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(value: record.particulars),
                    if (data.group != null)
                      buildTableCell(value: record.branch),
                    buildTableCell(
                      value: record.amount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          buildPurchaseRegisterFooter(data.summary.billAmount),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}

FutureOr<Uint8List> purchaseRegisterGroupViewDetailMode(
  PurchaseRegisterInput data,
) {
  final pdf = pw.Document();
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
                if (data.vendor != null)
                  buildFilterRow(
                    key: "Vendor",
                    value: data.vendor!,
                  ),
                if (data.paymentAccounts != null)
                  buildFilterRow(
                    key: "Account",
                    value: data.paymentAccounts!,
                  ),
                buildFilterRow(
                  key: "Payment Mode",
                  value: data.paymentMode ?? "All",
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            columnWidths: data.group != null
                ? {
                    0: const pw.FlexColumnWidth(1.5),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(1),
                    4: const pw.FlexColumnWidth(1),
                    5: const pw.FlexColumnWidth(1),
                  }
                : {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(1),
                    4: const pw.FlexColumnWidth(1),
                  },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Particulars",
                  ),
                  if (data.group != null)
                    buildTableCell(
                      isHeader: true,
                      value: "Branch",
                    ),
                  buildTableCell(
                    isHeader: true,
                    value: "Bank",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Cash",
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Credit",
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
            columnWidths: data.group != null
                ? {
                    0: const pw.FlexColumnWidth(1.5),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(1),
                    4: const pw.FlexColumnWidth(1),
                    5: const pw.FlexColumnWidth(1),
                    6: const pw.FlexColumnWidth(1),
                  }
                : {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(1),
                    4: const pw.FlexColumnWidth(1),
                    5: const pw.FlexColumnWidth(1),
                  },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(value: record.particulars),
                    if (data.group != null)
                      buildTableCell(value: record.branch),
                    buildTableCell(
                      value: record.bankAmount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: record.cashAmount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: record.creditAmount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      value: record.amount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          buildPurchaseRegDetailModeFooter(data.summary),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}
