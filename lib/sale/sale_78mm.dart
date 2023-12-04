import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../main.dart';
import 'input.dart';

FutureOr<Uint8List> buildSaleLayoutA(
  SaleData data,
  SaleLayoutAConfig config,
) {
  Widget buildDivider({double? height}) {
    return Divider(
      height: height ?? 5,
      color: PdfColors.grey800,
    );
  }

  Widget buildHeader(Context context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          data.orgName,
          style: Theme.of(context).header1,
        ),
        if (config.showOrganizationAddress) ...[
          if (data.branchInfo.address.address != null)
            Text(
              data.branchInfo.address.address!,
            ),
          if (data.branchInfo.address.city != null)
            Text(
              '${data.branchInfo.address.city!}-${data.branchInfo.address.pincode ?? 1}',
            ),
        ],
        if (config.showOrganizationPhone)
          if (data.branchInfo.phone != null)
            Text(
              "Phone: ${data.branchInfo.phone}",
            ),
        if (config.showOrganizationMobile)
          if (data.branchInfo.mobileNos != null &&
              data.branchInfo.mobileNos!.isNotEmpty)
            Text(
              "Mobile: ${data.branchInfo.mobileNos?.join(",").toString()}",
            ),
        if (config.showOrganizationEmail)
          if (data.branchInfo.email != null)
            Text(
              "Email: ${data.branchInfo.email}",
            ),
        if (config.showGstNo)
          Text(
            "GSTIN: ${data.branchInfo.gstNo}",
          ),
        if (config.showLicNo)
          if (data.branchInfo.licNo != null)
            Text(
              "LIC.NO: ${data.branchInfo.licNo}",
            ),
        Text(
          data.voucherInfo.voucherName,
          style: Theme.of(context).header1,
        ),
      ],
    );
  }

  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);

  final pageFormat = PdfPageFormat(
    mm(config.pageWidth),
    double.infinity,
    marginAll: mm(config.margin),
  );

  final List<FlexColumnWidth> colWidths = [];
  if (config.mrp.width > 0) {
    colWidths.add(FlexColumnWidth(config.mrp.width));
  }
  if (config.rate.width > 0) {
    colWidths.add(FlexColumnWidth(config.rate.width));
  }
  if (config.qty.width > 0) {
    colWidths.add(FlexColumnWidth(config.qty.width));
  }
  if (config.discount.width > 0) {
    colWidths.add(FlexColumnWidth(config.discount.width));
  }
  if (config.amount.width > 0) {
    colWidths.add(FlexColumnWidth(config.amount.width));
  }

  pdf.addPage(
    Page(
      pageTheme: PageTheme(
        pageFormat: pageFormat,
        theme: ThemeData(
          defaultTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
          ),
          paragraphStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            lineSpacing: -1,
          ),
          header0: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
          ),
          header1: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
          ),
        ),
      ),
      build: (context) {
        return Column(
          children: [
            buildHeader(context),
            buildDivider(),
            Table(
              columnWidths: {
                0: const FlexColumnWidth(1.5),
                1: const FlexColumnWidth(0.2),
                2: const FlexColumnWidth(4),
              },
              children: [
                TableRow(
                  children: [
                    Text("Bill No"),
                    Text(":"),
                    Text(data.voucherInfo.voucherNo),
                  ],
                ),
                TableRow(
                  children: [
                    Text("Date"),
                    Text(":"),
                    Text(data.voucherInfo.date),
                  ],
                ),
              ],
            ),
            buildDivider(),
            if (config.item.width > 0)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(config.item.label),
              ),
            Table(
              columnWidths: colWidths.asMap(),
              children: [
                TableRow(
                  children: [
                    if (config.mrp.width > 0) Text(config.mrp.label),
                    if (config.rate.width > 0) Text(config.rate.label),
                    if (config.qty.width > 0) Text(config.qty.label),
                    if (config.discount.width > 0) Text(config.discount.label),
                    if (config.amount.width > 0)
                      Text(
                        config.amount.label,
                        textAlign: TextAlign.end,
                      ),
                  ],
                ),
              ],
            ),
            buildDivider(),
            for (final record in data.items) ...[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  record.name,
                ),
              ),
              Table(
                columnWidths: colWidths.asMap(),
                children: [
                  TableRow(
                    children: [
                      if (config.mrp.width > 0)
                        Text(record.mrp.toStringAsFixed(2)),
                      if (config.rate.width > 0)
                        Text(record.rate.toStringAsFixed(2)),
                      if (config.qty.width > 0)
                        Text(record.qty.toStringAsFixed(record.precision)),
                      if (config.discount.width > 0)
                        Text(
                          record.disc?.mode == 'P'
                              ? '${record.disc?.amount.toStringAsFixed(2)}%'
                              : '',
                        ),
                      if (config.amount.width > 0)
                        Text(
                          (record.taxableValue +
                                  record.cgstAmount +
                                  record.sgstAmount +
                                  record.igstAmount +
                                  record.cessAmount)
                              .toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                    ],
                  ),
                ],
              ),
            ],
            buildDivider(),
            Table(
              columnWidths: {
                0: const FlexColumnWidth(2.8),
                1: const FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      config.qty.width > 0
                          ? 'TOTAL [Qty-${data.items.fold(0.0, (preValue, x) => preValue + x.qty).toStringAsFixed(2)}]'
                          : 'TOTAL',
                    ),
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
                                x.cessAmount,
                          )
                          .toStringAsFixed(2),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
            buildDivider(),
            Table(
              columnWidths: {
                0: const FlexColumnWidth(2.2),
                1: const FlexColumnWidth(0.2),
                2: const FlexColumnWidth(2),
              },
              children: [
                if (data.discount != 0)
                  TableRow(
                    children: [
                      Text("BILL DISCOUNT", textAlign: TextAlign.end),
                      Text(":", textAlign: TextAlign.end),
                      Text(
                        data.discount.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                if (data.rounded != 0)
                  TableRow(
                    children: [
                      Text(
                        "ROUND OFF",
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.end,
                      ),
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
                        textAlign: TextAlign.end,
                        style: Theme.of(context).header0,
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).header0,
                      ),
                      Text(
                        'Rs.${data.netAmount.toStringAsFixed(2)}',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).header0,
                      ),
                    ],
                  ),
              ],
            ),
            buildDivider(),
            Table(
              columnWidths: {
                0: const FlexColumnWidth(2.5),
                1: const FlexColumnWidth(1.5),
                2: const FlexColumnWidth(1.5),
                3: const FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: PdfColors.grey800),
                    ),
                  ),
                  children: [
                    Text("GST %"),
                    Text("CGST", textAlign: TextAlign.end),
                    Text("SGST", textAlign: TextAlign.end),
                    Text("CESS", textAlign: TextAlign.end),
                  ],
                ),
                for (final summary in data.taxSummary)
                  TableRow(
                    children: [
                      Text(
                        "${summary.ratio}% on ${summary.value}",
                      ),
                      Text(
                        summary.cgst.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        summary.sgst.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        summary.cess.toStringAsFixed(2),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: PdfColors.grey800),
                    ),
                  ),
                  children: [
                    Text(
                      "",
                    ),
                    Text(
                      data.taxSummary
                          .fold(0.0, (prevVal, x) => prevVal + x.cgst)
                          .toStringAsFixed(2),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      data.taxSummary
                          .fold(0.0, (prevVal, x) => prevVal + x.sgst)
                          .toStringAsFixed(2),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      data.taxSummary
                          .fold(0.0, (prevVal, x) => prevVal + x.cess)
                          .toStringAsFixed(2),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "TOTAL GST : ${data.taxSummary.fold(0.0, (preValue, x) => preValue + x.cgst + x.sgst + x.igst + x.cess).toStringAsFixed(2)}",
            ),
            buildDivider(),
            if (config.termsAndConditions != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final cfg in config.termsAndConditions!)
                    Text(
                      "#$cfg.",
                      style: Theme.of(context).paragraphStyle,
                    ),
                ],
              ),
            if (config.greetings != null) ...[
              SizedBox(height: 5),
              Text(
                config.greetings!,
                style: Theme.of(context).paragraphStyle,
              ),
            ]
          ],
        );
      },
    ),
  );
  return pdf.save();
}
