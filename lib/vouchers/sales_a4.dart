import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../main.dart';
import 'footer.dart';
import 'sale_input.dart';

FutureOr<Uint8List> buildlayoutB(
  SalePdfData data,
  SalePdfLayoutBConfig config,
) {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.courier();
  final bold = pw.Font.courierBold();
  final pageFormat = PdfPageFormat(
    mm(config.pageWidth),
    mm(config.pageHeight),
    marginAll: mm(5),
  );

  final List<pw.FlexColumnWidth> colWidths = [];
  if (config.transactionInfo.serialNo.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.serialNo.width));
  }
  if (config.transactionInfo.item.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.item.width));
  }
  if (config.transactionInfo.hsnCode.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.hsnCode.width));
  }
  if (config.transactionInfo.qty.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.qty.width));
  }
  if (config.transactionInfo.mrp.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.mrp.width));
  }
  if (config.transactionInfo.rate.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.rate.width));
  }
  if (config.transactionInfo.taxableValue.enabled) {
    colWidths
        .add(pw.FlexColumnWidth(config.transactionInfo.taxableValue.width));
  }
  if (config.transactionInfo.taxRatio.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.taxRatio.width));
  }
  if (config.transactionInfo.taxAmount.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.taxAmount.width));
  }
  if (config.transactionInfo.amount.enabled) {
    colWidths.add(pw.FlexColumnWidth(config.transactionInfo.amount.width));
  }

  final value = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.value);
  final cgst = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.cgst);
  final sgst = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.sgst);
  final igst = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.igst);
  final cess = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.cess);

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat,
        theme: pw.ThemeData.withFont(base: font, bold: bold),
        buildBackground: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey800),
            ),
          );
        },
      ),
      footer: (context) => buildFooter(context),
      build: (context) {
        return [
          buildVoucherHeader(data: saleData, config: salePdfLayoutBConfig),
          pw.Divider(color: PdfColors.grey800, height: 0),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(1.5),
              1: const pw.FlexColumnWidth(1),
            },
            border: pw.TableBorder.symmetric(
              inside: const pw.BorderSide(color: PdfColors.grey800),
            ),
            children: [
              pw.TableRow(
                children: [
                  config.header.showPartyInfo
                      ? pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "To",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              if (data.partyInfo.name != null)
                                pw.Text(
                                  data.partyInfo.name!,
                                  style: const pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              if (data.partyInfo.address?.address != null)
                                pw.Text(
                                  data.partyInfo.address!.address!,
                                  style: const pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              pw.Text(
                                '${partyInfoAddr1(data)},${partyInfoAddr2(data)}',
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        "Mobile:",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                        (data.partyInfo.mobileNos != null)
                                            ? data.partyInfo.mobileNos!
                                                .join(',')
                                            : '',
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        "GSTIN:",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                        data.branchInfo.gstNo,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : pw.Text(""),
                  config.header.showVoucherInfo
                      ? pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Table(
                            columnWidths: {
                              0: const pw.FlexColumnWidth(1),
                              1: const pw.FlexColumnWidth(0.1),
                              2: const pw.FlexColumnWidth(1.5),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Invoice No",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    data.voucherInfo.voucherNo,
                                    style: const pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Invoice Date",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    data.voucherInfo.date,
                                    style: const pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Invoice Time",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    data.voucherInfo.date,
                                    style: const pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              if (data.voucherInfo.refNo != null)
                                pw.TableRow(
                                  children: [
                                    pw.Text(
                                      "Ref.No",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      ":",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      data.voucherInfo.refNo!,
                                      style: const pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              if (data.deliveryInfo.date != null)
                                pw.TableRow(
                                  children: [
                                    pw.Text(
                                      "Delivery Date",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      ":",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      data.deliveryInfo.date!,
                                      style: const pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              if (data.deliveryInfo.transport != null)
                                pw.TableRow(
                                  children: [
                                    pw.Text(
                                      "Transport",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      ":",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      data.deliveryInfo.transport!,
                                      style: const pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        )
                      : pw.Text("")
                ],
              ),
            ],
          ),
          pw.Divider(color: PdfColors.grey800, height: 0),
          pw.Table(
            border: pw.TableBorder.symmetric(
              inside: const pw.BorderSide(color: PdfColors.grey800),
            ),
            columnWidths: colWidths.asMap(),
            children: [
              pw.TableRow(
                children: [
                  if (config.transactionInfo.serialNo.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.serialNo.label ?? '#',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.item.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.item.label ?? 'ITEMS',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.hsnCode.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.hsnCode.label ?? 'HSN',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.qty.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.qty.label ?? 'QTY',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.mrp.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.mrp.label ?? 'MRP',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.rate.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.rate.label ?? 'RATE',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.taxableValue.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.taxableValue.label ??
                            'TAXABLE VALUE',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.taxRatio.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.taxRatio.label ?? 'TAX%',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.taxAmount.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.taxAmount.label ?? 'TAX AMT',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  if (config.transactionInfo.amount.enabled)
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        config.transactionInfo.amount.label ?? 'AMOUNT',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              for (final (idx, item) in data.items.indexed)
                pw.TableRow(
                  children: [
                    if (config.transactionInfo.serialNo.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          (idx + 1).toString(),
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.item.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.name,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.hsnCode.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.hsnCode ?? '',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.qty.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.qty.toStringAsFixed(item.precision),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.mrp.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.mrp.toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.rate.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.rate.toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.taxableValue.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.taxableValue.toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.taxRatio.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          item.taxRatio.toStringAsFixed(2),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.taxAmount.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          (item.cgstAmount +
                                  item.sgstAmount +
                                  item.igstAmount +
                                  item.cessAmount)
                              .toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    if (config.transactionInfo.amount.enabled)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                          (item.taxableValue +
                                  item.cgstAmount +
                                  item.sgstAmount +
                                  item.igstAmount +
                                  item.cessAmount)
                              .toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
          pw.Divider(color: PdfColors.grey800, height: 0),
          pw.Container(
            alignment: pw.Alignment.centerRight,
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              "Total : ${data.items.fold(0.0, (preValue, x) => preValue + x.taxableValue + x.cgstAmount + x.sgstAmount + x.igstAmount + x.cessAmount).toStringAsFixed(2)}",
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Divider(color: PdfColors.grey800, height: 0),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
            },
            border: pw.TableBorder.symmetric(
              inside: const pw.BorderSide(color: PdfColors.grey800),
            ),
            children: [
              pw.TableRow(
                children: [
                  config.footer.showGSTSummary
                      ? pw.Container(
                          child: pw.Table(
                            border:
                                pw.TableBorder.all(color: PdfColors.grey800),
                            columnWidths: {
                              0: const pw.FlexColumnWidth(1),
                              1: const pw.FlexColumnWidth(1),
                              2: const pw.FlexColumnWidth(1),
                              3: const pw.FlexColumnWidth(1),
                              4: const pw.FlexColumnWidth(1),
                              5: const pw.FlexColumnWidth(1),
                              6: const pw.FlexColumnWidth(1),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Text(
                                      "GST%",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Text(
                                      "Value",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Text(
                                      "CGST",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Text(
                                      "SGST",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Text(
                                      "IGST",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Text(
                                      "CESS",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              for (final tax in data.taxSummary)
                                pw.TableRow(
                                  children: [
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(2),
                                      child: pw.Text(
                                        tax.ratio.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(2),
                                      child: pw.Text(
                                        tax.value.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(2),
                                      child: pw.Text(
                                        tax.cgst.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(2),
                                      child: pw.Text(
                                        tax.sgst.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(2),
                                      child: pw.Text(
                                        tax.igst.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(2),
                                      child: pw.Text(
                                        tax.cess.toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        )
                      : pw.Text(""),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Table(
                      columnWidths: {
                        0: const pw.FlexColumnWidth(1.5),
                        1: const pw.FlexColumnWidth(0.1),
                        2: const pw.FlexColumnWidth(1.5),
                      },
                      children: [
                        if (value != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Taxable Amount",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                value.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (data.shippingCharge != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Shipping Charges",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                data.shippingCharge.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (cgst != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Total CGST",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                cgst.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (sgst != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Total SGST",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                sgst.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (igst != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Total IGST",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                igst.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (cess != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Total CESS",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                cess.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (data.discount != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Bill Discount",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                data.discount.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (data.accountAdjustment != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Adjustment",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                data.accountAdjustment.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (data.rounded != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Rounded",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                data.rounded.toStringAsFixed(2),
                                textAlign: pw.TextAlign.end,
                                style: const pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        if (data.netAmount != 0)
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "NET AMOUNT",
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                ":",
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                'Rs.${data.netAmount.toStringAsFixed(2)}',
                                textAlign: pw.TextAlign.end,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          pw.Divider(color: PdfColors.grey800, height: 0),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
            },
            border: pw.TableBorder.symmetric(
              inside: const pw.BorderSide(color: PdfColors.grey800),
            ),
            children: [
              pw.TableRow(
                children: [
                  config.footer.showBankDetails!.enabled
                      ? pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Table(
                            columnWidths: {
                              0: const pw.FlexColumnWidth(1),
                              1: const pw.FlexColumnWidth(0.1),
                              2: const pw.FlexColumnWidth(3),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Bank Name",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    config.footer.showBankDetails!.bankName,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "A/C Name",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    config.footer.showBankDetails!.acName,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "A/C No",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    config.footer.showBankDetails!.acNo,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "IFSC Code",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    config.footer.showBankDetails!.ifscCode,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "PAN No",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    config.footer.showBankDetails!.panNo,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : pw.Text(""),
                  config.footer.showBillDetails
                      ? pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Table(
                            columnWidths: {
                              0: const pw.FlexColumnWidth(1.2),
                              1: const pw.FlexColumnWidth(0.1),
                              2: const pw.FlexColumnWidth(1.5),
                            },
                            children: [
                              if (data.salesManName != null)
                                pw.TableRow(
                                  children: [
                                    pw.Text(
                                      "SalesMan",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      ":",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      data.salesManName!,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Billed By",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    data.billedBy,
                                    style: const pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Delivered To",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    data.partyInfo.name ?? 'Customer',
                                    style: const pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    "Description",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    ":",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    data.description ?? '',
                                    style: const pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : pw.Text("")
                ],
              ),
            ],
          ),
          pw.Divider(color: PdfColors.grey800, height: 0),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(1),
            },
            border: pw.TableBorder.symmetric(
              inside: const pw.BorderSide(color: PdfColors.grey800),
            ),
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.only(top: 35, right: 2),
                    child: pw.Text(
                      "Receiver Signature",
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  if (config.footer.showBalanceDetails)
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Table(
                        columnWidths: {
                          0: const pw.FlexColumnWidth(1.5),
                          1: const pw.FlexColumnWidth(1)
                        },
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Balance O/S",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                  decoration: pw.TextDecoration.underline,
                                  decorationColor: PdfColors.grey800,
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Previous Balance",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                ": 0.00",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Bill Amount",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                ": 0.00",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text(
                                "Total Outstanding",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                ": 0.00",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.SizedBox(
                          height: 32,
                          child: pw.Text(
                            "For ${data.orgName}",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Authorized Signature",
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.Divider(color: PdfColors.grey800, height: 0),
          if (config.footer.termsAndConditions != null)
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Terms and Conditions",
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                      decorationColor: PdfColors.grey800,
                    ),
                  ),
                  for (final tc in config.footer.termsAndConditions!)
                    pw.Text(
                      "* $tc",
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
        ];
      },
    ),
  );

  return pdf.save();
}

partyInfoAddr1(SalePdfData data) {
  if (data.partyInfo.address?.city != null &&
      data.partyInfo.address?.pincode != null) {
    return '${data.partyInfo.address!.city!}-${data.partyInfo.address!.pincode!}';
  } else if (data.partyInfo.address?.city != null) {
    return data.partyInfo.address!.city!;
  } else if (data.partyInfo.address?.pincode != null) {
    return data.partyInfo.address!.pincode!;
  }
}

partyInfoAddr2(SalePdfData data) {
  if (data.partyInfo.address?.state != null &&
      data.partyInfo.address?.country != null) {
    return '${data.partyInfo.address!.state!},${data.partyInfo.address!.country!}';
  } else if (data.partyInfo.address?.state != null) {
    return data.partyInfo.address!.state!;
  } else if (data.partyInfo.address?.country != null) {
    return data.partyInfo.address!.country!;
  }
}

pw.Widget buildVoucherHeader({
  required SalePdfLayoutBConfig config,
  required SalePdfData data,
}) {
  return pw.Center(
    child: pw.Column(
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
              style: const pw.TextStyle(
                fontSize: 11,
              ),
            ),
          if (data.branchInfo.address.city != null)
            pw.Text(
              '${data.branchInfo.address.city!} - ${data.branchInfo.address.pincode ?? 1}',
              style: const pw.TextStyle(
                fontSize: 11,
              ),
            ),
        ],
        if (config.header.showOrganizationPhone) ...[
          if (data.branchInfo.phone != null)
            pw.Text(
              "Phone: ${data.branchInfo.phone}",
              style: const pw.TextStyle(
                fontSize: 11,
              ),
            ),
          if (data.branchInfo.mobileNos != null)
            pw.Text(
              "Mobile: ${data.branchInfo.mobileNos?.join(",").toString()}",
              style: const pw.TextStyle(
                fontSize: 11,
              ),
            ),
          if (data.branchInfo.email != null)
            pw.Text(
              "Email: ${data.branchInfo.email}",
              style: const pw.TextStyle(
                fontSize: 11,
              ),
            ),
        ],
        if (config.header.showOrganizationDetails) ...[
          pw.Text(
            "GSTIN: ${data.branchInfo.gstNo}",
            style: const pw.TextStyle(
              fontSize: 11,
            ),
          ),
          if (data.branchInfo.licNo != null)
            pw.Text(
              "LIC.NO: ${data.branchInfo.licNo}",
              style: const pw.TextStyle(
                fontSize: 11,
              ),
            ),
        ]
      ],
    ),
  );
}
