import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:print_pdf/common/report_header.dart';

import '../common/divider.dart';
import '../common/filter_row.dart';
import '../common/page_footer.dart';
import '../common/table_cell.dart';
import '../main.dart';

import 'sale_register_footer.dart';
import 'sale_register_input.dart';

FutureOr<Uint8List> saleRegisterDetail(
  SaleRegisterDetailInput data,
) {
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
                if (data.customer != null)
                  buildFilterRow(
                    key: "Customer",
                    value: data.customer!,
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
            columnWidths: {
              0: const pw.FlexColumnWidth(1.5),
              1: const pw.FlexColumnWidth(4),
              // 2: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(3.5),
              3: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    isHeader: true,
                    value: "Date",
                  ),
                  buildTableCell(
                    isHeader: true,
                    value: "Customer",
                  ),
                  // buildTableCell(
                  //   isHeader: true,
                  //   value: "Voucher Type",
                  // ),
                  buildTableCell(
                    isHeader: true,
                    value: "Ref No",
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
              0: const pw.FlexColumnWidth(1.5),
              1: const pw.FlexColumnWidth(4),
              // 2: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(3.5),
              3: const pw.FlexColumnWidth(2),
            },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(value: record.date),
                    buildTableCell(value: record.customer ?? ''),
                    // buildTableCell(
                    //   value: record.voucherType,
                    // ),
                    buildTableCell(
                      value: (record.refNo != null)
                          ? '${record.voucherNo}/${record.refNo}'
                          : record.voucherNo,
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
          buildSaleRegisterFooter(data.summary.billAmount),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}

FutureOr<Uint8List> saleRegisterDetailMode(
  SaleRegisterDetailInput data,
) {
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
            fromDate: data.fromDate,
            toDate: data.toDate,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Column(
              children: [
                buildFilterRow(key: "Branch", value: data.branches),
                if (data.customer != null)
                  buildFilterRow(key: "Customer", value: data.customer!),
                if (data.paymentAccounts != null)
                  buildFilterRow(key: "Account", value: data.paymentAccounts!),
                buildFilterRow(
                  key: "Payment Mode",
                  value: data.paymentMode ?? "All",
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Row(
            children: [
              buildTableCell(
                width: 78,
                value: "Date",
                isHeader: true,
              ),
              buildTableCell(
                width: 180,
                value: "Customer",
                isHeader: true,
              ),
              // buildTableCell(
              //   width: 100,
              //   value: "Voucher Type",
              //   isHeader: true,
              // ),
              buildTableCell(
                width: 180,
                value: "Ref No",
                isHeader: true,
              ),
              buildTableCell(
                width: 100,
                value: "Amount",
                isHeader: true,
                alignment: pw.Alignment.centerRight,
              ),
            ],
          ),
          buildDivider(),
          pw.Column(
            children: [
              for (final record in data.records) ...[
                pw.Row(
                  children: [
                    buildTableCell(
                      width: 78,
                      value: record.date,
                    ),
                    buildTableCell(
                      width: 180,
                      value: record.customer ?? '',
                    ),
                    // buildTableCell(
                    //   width: 100,
                    //   value: record.voucherType,
                    // ),
                    buildTableCell(
                      width: 180,
                      value: (record.refNo != null)
                          ? '${record.voucherNo}/${record.refNo}'
                          : record.voucherNo,
                    ),
                    buildTableCell(
                      width: 100,
                      value: record.amount.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    buildTableCell(
                      width: 135,
                      widget: pw.Text(
                        "Bank Amount : ${record.bankAmount.toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    buildTableCell(
                      width: 150,
                      widget: pw.Text(
                        "Cash Amount : ${record.cashAmount.toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    buildTableCell(
                      width: 135,
                      widget: pw.Text(
                        "Credit Amount : ${record.creditAmount.toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    buildTableCell(
                      width: 125,
                      widget: pw.Text(
                        "EFT Amount : ${record.eftAmount.toStringAsFixed(2)}",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                  ],
                ),
                buildDivider(),
              ]
            ],
          ),
          buildSaleRegDetailModeFooter(data.summary),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}
