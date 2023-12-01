import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../main.dart';
import 'sale_input.dart';

FutureOr<Uint8List> buildlayoutAconfig(
  SalePdfData data,
  SalePdfLayoutAConfig config,
) {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.courier();
  final bold = pw.Font.courierBold();

  final pageFormat =
      PdfPageFormat(mm(config.pageWidth), double.infinity, marginAll: mm(3));

  final List<pw.FlexColumnWidth> c = [];
  if (config.transactionInfo.mrp.enabled) {
    c.add(pw.FlexColumnWidth(config.transactionInfo.mrp.width));
  }
  if (config.transactionInfo.rate.enabled) {
    c.add(pw.FlexColumnWidth(config.transactionInfo.rate.width));
  }
  if (config.transactionInfo.qty.enabled) {
    c.add(pw.FlexColumnWidth(config.transactionInfo.qty.width));
  }
  if (config.transactionInfo.discount.enabled) {
    c.add(pw.FlexColumnWidth(config.transactionInfo.discount.width));
  }
  if (config.transactionInfo.amount.enabled) {
    c.add(pw.FlexColumnWidth(config.transactionInfo.amount.width));
  }
  final columnWidths = c.asMap();

  pdf.addPage(
    pw.Page(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: font,
        bold: bold,
      ),
      build: (context) {
        return pw.Column(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                if (config.header.showOrganizationName)
                  pw.Text(
                    data.orgName,
                    style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                if (config.header.showOrganizationAddress) ...[
                  if (data.branchInfo.address.address != null)
                    pw.Text(
                      data.branchInfo.address.address!,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  if (data.branchInfo.address.city != null)
                    pw.Text(
                      '${data.branchInfo.address.city!}-${data.branchInfo.address.pincode ?? 1}',
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                ],
                if (config.header.showOrganizationPhone) ...[
                  if (data.branchInfo.phone != null)
                    pw.Text(
                      "Phone: ${data.branchInfo.phone}",
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  if (data.branchInfo.mobileNos != null &&
                      data.branchInfo.mobileNos!.isNotEmpty)
                    pw.Text(
                      "Mobile: ${data.branchInfo.mobileNos?.join(",").toString()}",
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  if (data.branchInfo.email != null)
                    pw.Text(
                      "Email: ${data.branchInfo.email}",
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                ],
                if (config.header.showOrganizationDetails) ...[
                  pw.Text(
                    "GSTIN: ${data.branchInfo.gstNo}",
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  if (data.branchInfo.licNo != null)
                    pw.Text(
                      "LIC.NO: ${data.branchInfo.licNo}",
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                ],
                pw.Text(
                  data.voucherInfo.voucherName,
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.Divider(
              height: 0,
              color: PdfColors.grey800,
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 1),
              child: pw.Table(
                columnWidths: {
                  0: const pw.FlexColumnWidth(1.5),
                  1: const pw.FlexColumnWidth(0.2),
                  2: const pw.FlexColumnWidth(4),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "Bill No",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        data.voucherInfo.voucherNo,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "Date",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        data.voucherInfo.date,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.Divider(
              height: 0,
              color: PdfColors.grey800,
            ),
            if (config.transactionInfo.item.enabled)
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  config.transactionInfo.item.label ?? 'PARTICULARS',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            pw.Table(
              columnWidths: columnWidths,
              children: [
                pw.TableRow(
                  children: [
                    if (config.transactionInfo.mrp.enabled)
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                        child: pw.Text(
                          config.transactionInfo.mrp.label ?? 'MRP',
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.rate.enabled)
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                        child: pw.Text(
                          config.transactionInfo.rate.label ?? 'RATE',
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.qty.enabled)
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                        child: pw.Text(
                          config.transactionInfo.qty.label ?? 'QTY',
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.discount.enabled)
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                        child: pw.Text(
                          config.transactionInfo.discount.label ?? 'DISC',
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.amount.enabled)
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                        child: pw.Text(
                          config.transactionInfo.amount.label ?? 'AMOUNT',
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            pw.Divider(
              height: 2,
              color: PdfColors.grey800,
            ),
            for (final record in data.items) ...[
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  record.name,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Table(
                columnWidths: columnWidths,
                children: [
                  pw.TableRow(
                    children: [
                      if (config.transactionInfo.mrp.enabled)
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                          child: pw.Text(
                            record.mrp.toStringAsFixed(2),
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      if (config.transactionInfo.rate.enabled)
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                          child: pw.Text(
                            record.rate.toStringAsFixed(2),
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      if (config.transactionInfo.qty.enabled)
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                          child: pw.Text(
                            record.qty.toStringAsFixed(record.precision),
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      if (config.transactionInfo.discount.enabled)
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                          child: pw.Text(
                            record.disc?.mode == 'P'
                                ? '${record.disc?.amount.toStringAsFixed(2)}%'
                                : '',
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      if (config.transactionInfo.amount.enabled)
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                          child: pw.Text(
                            (record.taxableValue +
                                    record.cgstAmount +
                                    record.sgstAmount +
                                    record.igstAmount +
                                    record.cessAmount)
                                .toStringAsFixed(2),
                            textAlign: pw.TextAlign.end,
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
            pw.Divider(
              height: 2,
              color: PdfColors.grey800,
            ),
            pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2.8),
                1: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                      child: pw.Text(
                        config.transactionInfo.qty.enabled
                            ? 'TOTAL [Qty-${data.items.fold(0.0, (preValue, x) => preValue + x.qty).toStringAsFixed(2)}]'
                            : 'TOTAL',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // if (config.transactionInfo.qty.enabled)
                    //   pw.Padding(
                    //     padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                    //     child: pw.Text(
                    //       data.items
                    //           .fold(0.0, (preValue, x) => preValue + x.qty)
                    //           .toString(),
                    //       style: pw.TextStyle(
                    //         fontSize: 11,
                    //         fontWeight: pw.FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 1),
                      child: pw.Text(
                        data.items
                            .fold(
                              0.0,
                              (preValue, x) =>
                                  preValue +
                                  x.taxableValue +
                                  x.cgstAmount +
                                  x.sgstAmount +
                                  x.igstAmount +
                                  x.cessAmount,
                            )
                            .toStringAsFixed(2),
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.Divider(
              height: 2,
              color: PdfColors.grey800,
            ),
            pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2.2),
                1: const pw.FlexColumnWidth(0.2),
                2: const pw.FlexColumnWidth(2),
              },
              children: [
                if (data.discount != 0)
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "BILL DISCOUNT",
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ":",
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        data.discount.toStringAsFixed(2),
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                if (data.rounded != 0)
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "ROUND OFF",
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ":",
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        data.rounded.toStringAsFixed(2),
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                if (data.netAmount != 0)
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "NET AMOUNT",
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ":",
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Rs.${data.netAmount.toStringAsFixed(2)}',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            pw.Divider(
              height: 2,
              color: PdfColors.grey800,
            ),
            pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2.5),
                1: const pw.FlexColumnWidth(1.5),
                2: const pw.FlexColumnWidth(1.5),
                3: const pw.FlexColumnWidth(1.5),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.grey800),
                    ),
                  ),
                  children: [
                    pw.Text(
                      "GST %",
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "CGST",
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "SGST",
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "CESS",
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    // pw.Text(
                    //   "TOTAL",
                    //   textAlign: pw.TextAlign.end,
                    //   style: pw.TextStyle(
                    //     fontSize: 11,
                    //     fontWeight: pw.FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                for (final summary in data.taxSummary)
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "${summary.ratio}% on ${summary.value}",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        summary.cgst.toStringAsFixed(2),
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        summary.sgst.toStringAsFixed(2),
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        summary.cess.toStringAsFixed(2),
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(color: PdfColors.grey800),
                    ),
                  ),
                  children: [
                    pw.Text(
                      "",
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      data.taxSummary
                          .fold(0.0, (prevVal, x) => prevVal + x.cgst)
                          .toStringAsFixed(2),
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      data.taxSummary
                          .fold(0.0, (prevVal, x) => prevVal + x.sgst)
                          .toStringAsFixed(2),
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      data.taxSummary
                          .fold(0.0, (prevVal, x) => prevVal + x.cess)
                          .toStringAsFixed(2),
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.Text(
              "TOTAL GST : ${data.taxSummary.fold(0.0, (preValue, x) => preValue + x.cgst + x.sgst + x.igst + x.cess).toStringAsFixed(2)}",
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Divider(
              height: 2,
              color: PdfColors.grey800,
            ),
            if (config.footer.termsAndConditions != null)
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    for (final cfg in config.footer.termsAndConditions!)
                      pw.Text(
                        "# $cfg",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            pw.SizedBox(height: 5),
            if (config.footer.greetings != null)
              pw.Text(
                config.footer.greetings!,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}
