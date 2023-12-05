import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../common/divider.dart';
import '../common/page_footer.dart';
import '../main.dart';
import 'input.dart';

FutureOr<Uint8List> buildStockTransferLayout(
  StockTransferData data,
  StockTransferConfig config,
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
            border: const TableBorder(
              verticalInside: BorderSide(color: PdfColors.grey800),
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
                                Table(
                                  columnWidths: {
                                    0: const FlexColumnWidth(0.4),
                                    1: const FlexColumnWidth(0.1),
                                    2: const FlexColumnWidth(1),
                                  },
                                  children: [
                                    if (config.showOrganizationPhone)
                                      if (data.branchInfo.phone != null)
                                        TableRow(
                                          children: [
                                            Text(
                                              "Phone",
                                              style: Theme.of(context).header1,
                                            ),
                                            Text(
                                              ":",
                                              style: Theme.of(context).header1,
                                            ),
                                            if (data.branchInfo.phone != null)
                                              Text(
                                                "${data.branchInfo.phone}",
                                              ),
                                          ],
                                        ),
                                    if (config.showOrganizationMobile)
                                      if (data.branchInfo.mobileNos != null &&
                                          data.branchInfo.mobileNos!.isNotEmpty)
                                        TableRow(
                                          children: [
                                            Text(
                                              "Mobile",
                                              style: Theme.of(context).header1,
                                            ),
                                            Text(
                                              ":",
                                              style: Theme.of(context).header1,
                                            ),
                                            Text(
                                              "${data.branchInfo.mobileNos?.first}",
                                            ),
                                          ],
                                        ),
                                    // TableRow(
                                    //   children: [
                                    //     if (config.showOrganizationPhone ||
                                    //         config.showOrganizationMobile)
                                    //       Text(
                                    //         "Phone",
                                    //         style: Theme.of(context).header1,
                                    //       ),
                                    //     Text(
                                    //       ":",
                                    //       style: Theme.of(context).header1,
                                    //     ),
                                    //     if (data.branchInfo.phone != null &&
                                    //         (data.branchInfo.mobileNos !=
                                    //                 null &&
                                    //             data.branchInfo.mobileNos!
                                    //                 .isNotEmpty)) ...[
                                    //       Text(
                                    //         "${data.branchInfo.phone},${data.branchInfo.mobileNos?.first}",
                                    //       ),
                                    //     ] else if (data.branchInfo.phone !=
                                    //         null)
                                    //       Text("${data.branchInfo.phone}")
                                    //     else if (data.branchInfo.mobileNos !=
                                    //             null &&
                                    //         data.branchInfo.mobileNos!
                                    //             .isNotEmpty)
                                    //       Text(
                                    //         "${data.branchInfo.mobileNos?.first}",
                                    //       )
                                    //   ],
                                    // ),
                                    if (config.showOrganizationEmail)
                                      if (data.branchInfo.email != null)
                                        TableRow(
                                          children: [
                                            Text(
                                              "Email",
                                              style: Theme.of(context).header1,
                                            ),
                                            Text(
                                              ":",
                                              style: Theme.of(context).header1,
                                            ),
                                            Text(
                                              "${data.branchInfo.email}",
                                            ),
                                          ],
                                        ),
                                    TableRow(
                                      children: [
                                        Text(
                                          "Branch",
                                          style: Theme.of(context).header1,
                                        ),
                                        Text(
                                          ":",
                                          style: Theme.of(context).header1,
                                        ),
                                        Text(
                                          data.branchInfo.displayName,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                  config.showVoucherInfo
                      ? Container(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Text(
                                data.voucherInfo.voucherName,
                                style: Theme.of(context).header2,
                              ),
                              Table(
                                columnWidths: {
                                  0: const FlexColumnWidth(0.8),
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
                                        "Date",
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
                                  TableRow(
                                    children: [
                                      Text(
                                        "Time",
                                        style: Theme.of(context).header1,
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).header1,
                                      ),
                                      Text(
                                        data.voucherInfo.time,
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
                      : Text('')
                ],
              ),
            ],
          ),
          buildDivider(),
          if (config.showAlternateBranchInfo) ...[
            Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Text(
                    "To : ",
                    style: Theme.of(context).header1,
                  ),
                  Text(data.altBranchInfo.displayName),
                ],
              ),
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
                          item.qty.toStringAsFixed(item.precision.toInt()),
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
