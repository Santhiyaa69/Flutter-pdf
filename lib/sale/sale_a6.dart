import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../common/divider.dart';
import '../common/page_footer.dart';
import '../main.dart';
import 'input.dart';

FutureOr<Uint8List> buildSaleLayoutA6(
  SaleData data,
  SaleLayoutA6Config config,
) {
  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);
  final pageFormat = PdfPageFormat(
    mm(config.pageWidth),
    mm(config.pageHeight),
    marginAll: mm(config.margin),
  );

  final List<FlexColumnWidth> colWidths = [];
  if (config.item.width > 0) {
    colWidths.add(FlexColumnWidth(config.item.width));
  }
  if (config.rack.width > 0) {
    colWidths.add(FlexColumnWidth(config.rack.width));
  }
  if (config.batchNo.width > 0) {
    colWidths.add(FlexColumnWidth(config.batchNo.width));
  }
  if (config.expiry.width > 0) {
    colWidths.add(FlexColumnWidth(config.expiry.width));
  }
  if (config.qty.width > 0) {
    colWidths.add(FlexColumnWidth(config.qty.width));
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

  pdf.addPage(
    MultiPage(
      pageTheme: PageTheme(
        pageFormat: pageFormat,
        theme: ThemeData(
          defaultTextStyle: TextStyle(
            fontSize: 9,
            font: Font.courier(),
          ),
          header0: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
          ),
          header1: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
          ),
          header2: TextStyle(
            fontSize: 10,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: PdfColors.grey800,
          ),
          header3: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
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
      footer: (context) => buildPageFooter(context),
      build: (context) {
        return [
          Table(
            border: TableBorder.symmetric(
              inside: const BorderSide(color: PdfColors.grey800),
            ),
            columnWidths: {
              0: const FlexColumnWidth(2),
              1: const FlexColumnWidth(1)
            },
            children: [
              TableRow(
                children: [
                  Table(
                    columnWidths: {
                      0: const FlexColumnWidth(1.2),
                      1: const FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (config.showOrganizationName)
                                  Text(
                                    data.orgName,
                                    style: Theme.of(context).header0,
                                  ),
                                if (config.showOrganizationAddress) ...[
                                  if (data.branchInfo.address.address != null)
                                    Text(data.branchInfo.address.address!),
                                  if (data.branchInfo.address.city != null)
                                    Text(
                                        '${data.branchInfo.address.city!} - ${data.branchInfo.address.pincode ?? 1}'),
                                ],
                                if (config.showOrganizationPhone) ...[
                                  Row(
                                    children: [
                                      Text(
                                        "Phone:",
                                        style: Theme.of(context).header1,
                                      ),
                                      if (data.branchInfo.phone != null &&
                                          data.branchInfo.mobileNos !=
                                              null) ...[
                                        Text(
                                          "${data.branchInfo.phone},${data.branchInfo.mobileNos?.first}",
                                        ),
                                      ] else if (data.branchInfo.mobileNos !=
                                          null) ...[
                                        Text(
                                          "${data.branchInfo.mobileNos?.first}",
                                        ),
                                      ],
                                    ],
                                  ),
                                  if (data.branchInfo.email != null)
                                    Row(
                                      children: [
                                        Text(
                                          "Email:",
                                          style: Theme.of(context).header1,
                                        ),
                                        Text(
                                          "${data.branchInfo.email}",
                                        ),
                                      ],
                                    ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "GSTIN:",
                                      style: Theme.of(context).header1,
                                    ),
                                    Text(data.branchInfo.gstNo),
                                  ],
                                ),
                                if (data.branchInfo.licNo != null)
                                  Row(
                                    children: [
                                      Text(
                                        "LIC NO:",
                                        style: Theme.of(context).header1,
                                      ),
                                      Text(
                                        data.branchInfo.licNo!,
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
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        Text(
                          data.voucherInfo.voucherName,
                          style: Theme.of(context).header2,
                        ),
                        Table(
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
                                  style: Theme.of(context).header1,
                                ),
                                Text(
                                  ":",
                                  style: Theme.of(context).header1,
                                ),
                                Text(
                                  data.voucherInfo.voucherNo,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Bill Date",
                                  style: Theme.of(context).header1,
                                ),
                                Text(
                                  ":",
                                  style: Theme.of(context).header1,
                                ),
                                Text(
                                  data.voucherInfo.date,
                                ),
                              ],
                            ),
                            if (data.voucherInfo.refNo != null)
                              TableRow(
                                children: [
                                  Text(
                                    "Ref.No",
                                    style: Theme.of(context).header1,
                                  ),
                                  Text(
                                    ":",
                                    style: Theme.of(context).header1,
                                  ),
                                  Text(
                                    data.voucherInfo.refNo!,
                                  ),
                                ],
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
          buildDivider(),
          if (config.showContactInfo)
            if (data.patientName != null && data.doctorName != null) ...[
              Table(
                columnWidths: {
                  0: const FlexColumnWidth(1),
                  1: const FlexColumnWidth(1),
                },
                border: TableBorder.symmetric(
                  inside: const BorderSide(color: PdfColors.grey800),
                ),
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          children: [
                            Text(
                              "Patient Name :",
                              style: Theme.of(context).header1,
                            ),
                            Text(
                              data.patientName!,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          children: [
                            Text(
                              "Doctor Name :",
                              style: Theme.of(context).header1,
                            ),
                            Text(
                              data.doctorName!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              buildDivider(),
            ],
          Table(
            columnWidths: colWidths.asMap(),
            border: const TableBorder(
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              TableRow(
                children: [
                  if (config.item.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.item.label,
                        style: Theme.of(context).header1,
                      ),
                    ),
                  if (config.rack.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.rack.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (config.batchNo.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.batchNo.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (config.expiry.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.expiry.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (config.qty.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.qty.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (config.mrp.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.mrp.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  if (config.rate.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.rate.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  if (config.discount.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.discount.label,
                        style: Theme.of(context).header1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  if (config.amount.width > 0)
                    Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        config.amount.label,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).header1,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Table(
            columnWidths: colWidths.asMap(),
            border: const TableBorder(
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              for (final item in data.items)
                TableRow(
                  children: [
                    if (config.item.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.name,
                        ),
                      ),
                    if (config.rack.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.rack ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.batchNo.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.batchNo ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.expiry.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.expiry ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.qty.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.qty.toStringAsFixed(item.precision),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (config.mrp.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.mrp.toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    if (config.rate.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.rate.toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    if (config.discount.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          item.dAmount.toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    if (config.amount.width > 0)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          (item.taxableValue +
                                  item.cgstAmount +
                                  item.sgstAmount +
                                  item.igstAmount +
                                  item.cessAmount)
                              .toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                  ],
                ),
            ],
          ),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(1),
              1: const FlexColumnWidth(1),
            },
            border: TableBorder.symmetric(
              inside: const BorderSide(color: PdfColors.grey800),
            ),
            children: [
              TableRow(
                children: [
                  config.showGSTSummary
                      ? Table(
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
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    "GST%",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).header1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    "Value",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).header1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    "CGST",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).header1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    "SGST",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).header1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    "IGST",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).header1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(
                                    "CESS",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).header1,
                                  ),
                                ),
                              ],
                            ),
                            for (final tax in data.taxSummary)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      '${tax.ratio.toStringAsFixed(2)}%',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      tax.value.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      tax.cgst.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      tax.sgst.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      tax.igst.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      tax.cess.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            "Note: This bill is under Composite Tax",
                          ),
                        ),
                  Table(
                    columnWidths: {
                      0: const FlexColumnWidth(1),
                      1: const FlexColumnWidth(1.2),
                    },
                    children: [
                      TableRow(
                        children: [
                          if (config.showBillDetails)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Table(
                                columnWidths: {
                                  0: const FlexColumnWidth(1),
                                  1: const FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Text("No of Items"),
                                      Text(
                                        ': ${data.items.length}',
                                      )
                                    ],
                                  ),
                                  if (data.salesManName != null)
                                    TableRow(
                                      children: [
                                        Text("SalesMan"),
                                        Text(': ${data.salesManName}')
                                      ],
                                    ),
                                  TableRow(
                                    children: [
                                      Text("Billed By"),
                                      Text(': ${data.billedBy}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Table(
                              columnWidths: {
                                0: const FlexColumnWidth(1),
                                1: const FlexColumnWidth(0.2),
                                2: const FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Text("Sub Total"),
                                    Text(":"),
                                    Text(
                                      data.items
                                          .fold(
                                              0.0,
                                              (preValue, x) =>
                                                  preValue +
                                                  x.taxableValue +
                                                  x.cgstAmount +
                                                  x.sgstAmount +
                                                  x.igstAmount +
                                                  x.cessAmount)
                                          .toStringAsFixed(2),
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
                                        style: Theme.of(context).header3,
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).header3,
                                      ),
                                      Text(
                                        data.netAmount.toStringAsFixed(2),
                                        style: Theme.of(context).header3,
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
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
