import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:print_pdf/common/divider.dart';
import 'package:print_pdf/purchase/input.dart';

import '../common/page_footer.dart';
import '../common/page_header.dart';
import '../common/utils.dart';
import '../common/voucher_header.dart';
import '../main.dart';

FutureOr<Uint8List> buildPurchaseLayout(
  PurchaseData data,
  PurchaseConfig config,
) {
  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);

  final pageFormat = PdfPageFormat(
    mm(config.pageWidth),
    mm(config.pageHeight),
    marginAll: mm(config.margin),
  );

  final List<FlexColumnWidth> colWidths = [];
  if (config.serialNo.width > 0) {
    colWidths.add(FlexColumnWidth(config.serialNo.width));
  }
  if (config.item.width > 0) {
    colWidths.add(FlexColumnWidth(config.item.width));
  }
  if (config.expiry.width > 0) {
    colWidths.add(FlexColumnWidth(config.expiry.width));
  }
  if (config.free.width > 0) {
    colWidths.add(FlexColumnWidth(config.free.width));
  }
  if (config.qty.width > 0) {
    colWidths.add(FlexColumnWidth(config.qty.width));
  }
  if (config.unit.width > 0) {
    colWidths.add(FlexColumnWidth(config.unit.width));
  }
  if (config.mrp.width > 0) {
    colWidths.add(FlexColumnWidth(config.mrp.width));
  }
  if (config.rate.width > 0) {
    colWidths.add(FlexColumnWidth(config.rate.width));
  }
  if (config.discount.width > 0) {
    colWidths.add(FlexColumnWidth(config.discount.width));
  }
  if (config.amount.width > 0) {
    colWidths.add(FlexColumnWidth(config.amount.width));
  }

  final value = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.value);
  final cgst = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.cgst);
  final sgst = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.sgst);
  final igst = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.igst);
  final cess = data.taxSummary.fold(0.0, (preValue, x) => preValue + x.cess);

  pdf.addPage(
    MultiPage(
      pageTheme: PageTheme(
        pageFormat: pageFormat,
        theme: ThemeData(
          defaultTextStyle: TextStyle(
            fontSize: 10,
            font: Font.courier(),
          ),
          header0: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
          ),
          header1: TextStyle(
            fontSize: 11,
            font: Font.courier(),
          ),
          header2: TextStyle(
            fontSize: 11,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            fontWeight: FontWeight.bold,
          ),
          header3: TextStyle(
            fontSize: 10,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            fontWeight: FontWeight.bold,
          ),
          header4: TextStyle(
            fontSize: 13,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            fontWeight: FontWeight.bold,
          ),
        ),
        buildBackground: (context) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: PdfColors.grey800),
            ),
          );
        },
      ),
      header: (context) => buildPageHeader(data.voucherInfo.voucherName),
      footer: (context) => buildPageFooter(context),
      build: (context) {
        return [
          buildVoucherHeader(
            context: context,
            orgName: data.orgName,
            branchInfo: data.branchInfo,
            showOrganizationAddress: config.showOrganizationAddress,
            showOrganizationPhone: config.showOrganizationPhone,
            showOrganizationMobile: config.showOrganizationMobile,
            showOrganizationEmail: config.showOrganizationEmail,
            showGstNo: config.showGstNo,
            showLicNo: config.showLicNo,
          ),
          buildDivider(height: 2),
          if (config.showPartyInfo || config.showVoucherInfo) ...[
            Table(
              columnWidths: {
                0: const FlexColumnWidth(1.5),
                1: const FlexColumnWidth(1),
              },
              border: TableBorder.symmetric(
                inside: const BorderSide(color: PdfColors.grey800),
              ),
              children: [
                TableRow(
                  children: [
                    config.showPartyInfo
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: Theme.of(context).header3,
                                ),
                                if (data.partyInfo.name != null)
                                  Text(data.partyInfo.name!),
                                if (data.partyInfo.address?.address != null)
                                  Text(data.partyInfo.address!.address!),
                                Text(
                                  '${partyInfoAddr1(data.partyInfo)},${partyInfoAddr2(data.partyInfo)}',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mobile:",
                                          style: Theme.of(context).header3,
                                        ),
                                        Text(
                                          (data.partyInfo.mobileNos != null)
                                              ? data.partyInfo.mobileNos!
                                                  .join(',')
                                              : '',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "GSTIN:",
                                          style: Theme.of(context).header3,
                                        ),
                                        Text(data.branchInfo.gstNo),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Text(""),
                    config.showVoucherInfo
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            child: Table(
                              columnWidths: {
                                0: const FlexColumnWidth(1),
                                1: const FlexColumnWidth(0.1),
                                2: const FlexColumnWidth(1.5),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      "Bill No",
                                      style: Theme.of(context).header3,
                                    ),
                                    Text(
                                      ":",
                                      style: Theme.of(context).header3,
                                    ),
                                    Text(data.voucherInfo.voucherNo),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Text(
                                      "Bill Date",
                                      style: Theme.of(context).header3,
                                    ),
                                    Text(
                                      ":",
                                      style: Theme.of(context).header3,
                                    ),
                                    Text(data.voucherInfo.date),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Text(
                                      "Bill Time",
                                      style: Theme.of(context).header3,
                                    ),
                                    Text(
                                      ":",
                                      style: Theme.of(context).header3,
                                    ),
                                    Text(data.voucherInfo.time),
                                  ],
                                ),
                                if (data.voucherInfo.refNo != null)
                                  TableRow(
                                    children: [
                                      Text(
                                        "RefNo",
                                        style: Theme.of(context).header3,
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).header3,
                                      ),
                                      Text(data.voucherInfo.refNo!),
                                    ],
                                  ),
                              ],
                            ),
                          )
                        : Text("")
                  ],
                ),
              ],
            ),
            buildDivider(),
          ],
          Table(
            border: const TableBorder(
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            columnWidths: colWidths.asMap(),
            children: [
              TableRow(
                children: [
                  if (config.serialNo.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.serialNo.label,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.item.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.item.label,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.expiry.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.expiry.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.free.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.free.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.qty.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.qty.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.unit.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.unit.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.mrp.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.mrp.label,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.rate.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.rate.label,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.taxableValue.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.taxableValue.label,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.taxRatio.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.taxRatio.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.taxAmount.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.taxAmount.label,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.discount.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.discount.label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  if (config.amount.width > 0)
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.amount.label,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).header2,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Table(
            border: const TableBorder(
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            columnWidths: colWidths.asMap(),
            children: [
              for (final (idx, item) in data.items.indexed)
                TableRow(
                  children: [
                    if (config.serialNo.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          (idx + 1).toString(),
                        ),
                      ),
                    if (config.item.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.name,
                        ),
                      ),
                    if (config.expiry.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.expiry ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.free.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          (item.free != null)
                              ? item.free!.toStringAsFixed(item.precision)
                              : '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.qty.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.qty.toStringAsFixed(item.precision),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.unit.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.unit,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.mrp.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.mrp.toStringAsFixed(2),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    if (config.rate.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.rate.toStringAsFixed(2),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    if (config.taxableValue.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.taxableValue.toStringAsFixed(2),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    if (config.taxRatio.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.taxRatio.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.taxAmount.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          (item.cgstAmount +
                                  item.sgstAmount +
                                  item.igstAmount +
                                  item.cessAmount)
                              .toStringAsFixed(2),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    if (config.discount.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          item.disc?.mode == "P"
                              ? '${item.disc?.amount.toStringAsFixed(2)}%'
                              : '${item.disc?.amount.toStringAsFixed(2)}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.amount.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          style: Theme.of(context).header1,
                          (item.taxableValue +
                                  item.cgstAmount +
                                  item.sgstAmount +
                                  item.igstAmount +
                                  item.cessAmount)
                              .toStringAsFixed(2),
                          textAlign: TextAlign.right,
                        ),
                      ),
                  ],
                ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(2),
            child: Text(
              "Total : ${data.items.fold(0.0, (preValue, x) => preValue + x.taxableValue + x.cgstAmount + x.sgstAmount + x.igstAmount + x.cessAmount).toStringAsFixed(2)}",
              style: Theme.of(context).header2,
            ),
          ),
          buildDivider(),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(1.5),
              1: const FlexColumnWidth(1),
            },
            border: const TableBorder(
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              TableRow(
                children: [
                  config.showGSTSummary
                      ? Container(
                          child: Table(
                            border: const TableBorder(
                              bottom: BorderSide(color: PdfColors.grey800),
                              verticalInside:
                                  BorderSide(color: PdfColors.grey800),
                              horizontalInside:
                                  BorderSide(color: PdfColors.grey800),
                            ),
                            columnWidths: {
                              0: const FlexColumnWidth(1),
                              1: const FlexColumnWidth(1),
                              2: const FlexColumnWidth(1),
                              3: const FlexColumnWidth(1),
                              4: const FlexColumnWidth(1),
                              5: const FlexColumnWidth(1),
                              6: const FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "GST%",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).header3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "Value",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).header3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "CGST",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).header3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "SGST",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).header3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "IGST",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).header3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "CESS",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).header3,
                                    ),
                                  ),
                                ],
                              ),
                              for (final tax in data.taxSummary)
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        '${tax.ratio.toStringAsFixed(2)}%',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        tax.value.toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        tax.cgst.toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        tax.sgst.toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        tax.igst.toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        tax.cess.toStringAsFixed(2),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        )
                      : Text(""),
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: Table(
                      columnWidths: {
                        0: const FlexColumnWidth(1.5),
                        1: const FlexColumnWidth(0.1),
                        2: const FlexColumnWidth(1.5),
                      },
                      children: [
                        if (value != 0)
                          TableRow(
                            children: [
                              Text("Taxable Amount"),
                              Text(":"),
                              Text(
                                value.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (cgst != 0)
                          TableRow(
                            children: [
                              Text("Total CGST"),
                              Text(":"),
                              Text(
                                cgst.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (sgst != 0)
                          TableRow(
                            children: [
                              Text("Total SGST"),
                              Text(":"),
                              Text(
                                sgst.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (igst != 0)
                          TableRow(
                            children: [
                              Text("Total IGST"),
                              Text(":"),
                              Text(
                                igst.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (cess != 0)
                          TableRow(
                            children: [
                              Text("Total CESS"),
                              Text(":"),
                              Text(
                                cess.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (data.discount != 0)
                          TableRow(
                            children: [
                              Text("Bill Discount"),
                              Text(":"),
                              Text(
                                data.discount.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (data.accountAdjustment != 0)
                          TableRow(
                            children: [
                              Text("Adjustment"),
                              Text(":"),
                              Text(
                                data.accountAdjustment.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (data.rounded != 0)
                          TableRow(
                            children: [
                              Text("Rounded"),
                              Text(":"),
                              Text(
                                data.rounded.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        if (data.netAmount != 0)
                          TableRow(
                            children: [
                              Text(
                                "NET AMOUNT",
                                style: Theme.of(context).header4,
                              ),
                              Text(
                                ":",
                                style: Theme.of(context).header4,
                              ),
                              Text(
                                'Rs.${data.netAmount.toStringAsFixed(2)}',
                                textAlign: TextAlign.end,
                                style: Theme.of(context).header4,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (config.showBillDetails)
            Table(
              columnWidths: {
                0: const FlexColumnWidth(1),
                1: const FlexColumnWidth(1),
              },
              border: const TableBorder(
                bottom: BorderSide(color: PdfColors.grey800),
                verticalInside: BorderSide(color: PdfColors.grey800),
              ),
              children: [
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Table(
                        columnWidths: {
                          0: const FlexColumnWidth(0.8),
                          1: const FlexColumnWidth(0.1),
                          2: const FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            children: [
                              Text(
                                "Billed By",
                                style: Theme.of(context).header3,
                              ),
                              Text(
                                ":",
                                style: Theme.of(context).header3,
                              ),
                              Text(data.billedBy)
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "Checked By",
                                style: Theme.of(context).header3,
                              ),
                              Text(
                                ":",
                                style: Theme.of(context).header3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: 50,
                      child: Text(
                        "For ${data.orgName}",
                        style: Theme.of(context).header3,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ];
      },
    ),
  );

  return pdf.save();
}
