import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:print_pdf/common/divider.dart';
import 'package:print_pdf/main.dart';

import '../common/voucher_header.dart';
import 'input.dart';

FutureOr<Uint8List> buildPayment(AccountVoucherData data) {
  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);

  final debitAccount = data.accountTransactions.where((x) => x.debit > 0);
  final creditAccount = data.accountTransactions.where((x) => x.credit > 0);

  pdf.addPage(
    MultiPage(
      pageTheme: PageTheme(
        pageFormat: PdfPageFormat(mm(210), mm(297), marginAll: mm(10)),
        theme: ThemeData(
          defaultTextStyle: TextStyle(
            fontSize: 11,
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
            fontWeight: FontWeight.bold,
            fontBold: Font.courierBold(),
          ),
          header3: TextStyle(
            fontSize: 11,
            font: Font.courier(),
            color: PdfColors.grey800,
          ),
          header4: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            decoration: TextDecoration.underline,
            decorationColor: PdfColors.grey800,
          ),
        ),
      ),
      build: (context) {
        return [
          buildVoucherHeader(
            context: context,
            orgName: data.orgName,
            branchInfo: data.branchInfo,
          ),
          buildDivider(height: 5),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            child: Text(
              data.voucherInfo.voucherName,
              style: Theme.of(context).header4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Voucher No  : ${data.voucherInfo.voucherNo}'),
                Text('Date  : ${data.voucherInfo.date}')
              ],
            ),
          ),
          if (data.description != null)
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text('Description : ${data.description}'),
            ),
          SizedBox(height: 5),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(2.5),
              1: const FlexColumnWidth(1),
            },
            border: const TableBorder(
              top: BorderSide(color: PdfColors.grey800),
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 5,
                    ),
                    child: Text(
                      'Particulars',
                      style: Theme.of(context).header2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 5,
                    ),
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).header2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(2.5),
              1: const FlexColumnWidth(1),
            },
            border: const TableBorder(
              verticalInside: BorderSide(color: PdfColors.grey800),
              bottom: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              for (final record in debitAccount) ...[
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        bottom: 1,
                        top: 10,
                      ),
                      child: Text(
                        record.account,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  ],
                ),
                if (record.adjs != null)
                  for (final adj in record.adjs!)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Table(
                            columnWidths: {
                              0: const FlexColumnWidth(0.6),
                              1: const FlexColumnWidth(1.5),
                              2: const FlexColumnWidth(1),
                            },
                            children: [
                              if (adj.refType == "adj") ...[
                                TableRow(
                                  children: [
                                    Text("Agst Ref :"),
                                    adj.refNo != null
                                        ? Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}/${adj.refNo}',
                                          )
                                        : Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}',
                                          ),
                                    adj.principalAmount >= 0
                                        ? Text(
                                            '${adj.principalAmount.toStringAsFixed(2)} Dr',
                                            textAlign: TextAlign.end,
                                          )
                                        : Text(
                                            '${adj.principalAmount.abs().toStringAsFixed(2)} Cr',
                                            textAlign: TextAlign.end,
                                          )
                                  ],
                                ),
                              ] else if (adj.refType == "new")
                                TableRow(
                                  children: [
                                    Text("New Ref  :"),
                                    adj.refNo != null
                                        ? Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}/${adj.refNo}',
                                          )
                                        : Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}',
                                          ),
                                    adj.paidAmount >= 0
                                        ? Text(
                                            '${adj.paidAmount.toStringAsFixed(2)} Dr',
                                            textAlign: TextAlign.end,
                                          )
                                        : Text(
                                            '${adj.paidAmount.abs().toStringAsFixed(2)} Cr',
                                            textAlign: TextAlign.end,
                                          )
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: adj.paidAmount >= 0
                              ? Text(
                                  '${adj.paidAmount.toStringAsFixed(2)} Dr',
                                  textAlign: TextAlign.end,
                                )
                              : Text(
                                  '${adj.paidAmount.abs().toStringAsFixed(2)} Cr',
                                  textAlign: TextAlign.end,
                                ),
                        ),
                      ],
                    ),
                if (record.onAccount != null && record.onAccount != 0)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("On Account"),
                            record.onAccount! >= 0
                                ? Text(
                                    '${record.onAccount!.toStringAsFixed(2)} Dr',
                                    textAlign: TextAlign.end,
                                  )
                                : Text(
                                    '${record.onAccount!.abs().toStringAsFixed(2)} Cr',
                                    textAlign: TextAlign.end,
                                  ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: record.onAccount! >= 0
                            ? Text(
                                '${record.onAccount!.toStringAsFixed(2)} Dr',
                                textAlign: TextAlign.end,
                              )
                            : Text(
                                '${record.onAccount!.abs().toStringAsFixed(2)} Cr',
                                textAlign: TextAlign.end,
                              ),
                      ),
                    ],
                  ),
              ],
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 2,
                      bottom: 1,
                      top: 10,
                    ),
                    child: Text(
                      'Through',
                      style: Theme.of(context).header2,
                    ),
                  ),
                ],
              ),
              for (final record in creditAccount)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(record.account),
                          Text('${record.credit.toStringAsFixed(2)} Cr')
                        ],
                      ),
                    ),
                    Text('')
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total Amount : ', style: Theme.of(context).header2),
                Text('${data.amount.toStringAsFixed(2)} Dr')
              ],
            ),
          ),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}

FutureOr<Uint8List> buildReceipt(AccountVoucherData data) {
  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);

  final creditAccount = data.accountTransactions.where((x) => x.credit > 0);
  final debitAccount = data.accountTransactions.where((x) => x.debit > 0);

  pdf.addPage(
    MultiPage(
      pageTheme: PageTheme(
        pageFormat: PdfPageFormat(mm(210), mm(297), marginAll: mm(10)),
        theme: ThemeData(
          defaultTextStyle: TextStyle(
            fontSize: 11,
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
            fontWeight: FontWeight.bold,
            fontBold: Font.courierBold(),
          ),
          header3: TextStyle(
            fontSize: 11,
            font: Font.courier(),
            color: PdfColors.grey800,
          ),
          header4: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            decoration: TextDecoration.underline,
            decorationColor: PdfColors.grey800,
          ),
        ),
      ),
      build: (context) {
        return [
          buildVoucherHeader(
            context: context,
            orgName: data.orgName,
            branchInfo: data.branchInfo,
          ),
          buildDivider(height: 5),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            child: Text(
              data.voucherInfo.voucherName,
              style: Theme.of(context).header4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Voucher No  : ${data.voucherInfo.voucherNo}'),
                Text('Date  : ${data.voucherInfo.date}')
              ],
            ),
          ),
          if (data.description != null)
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text('Description : ${data.description}'),
            ),
          SizedBox(height: 5),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(2.5),
              1: const FlexColumnWidth(1),
            },
            border: const TableBorder(
              top: BorderSide(color: PdfColors.grey800),
              bottom: BorderSide(color: PdfColors.grey800),
              verticalInside: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 5,
                    ),
                    child: Text(
                      'Particulars',
                      style: Theme.of(context).header2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 5,
                    ),
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).header2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(2.5),
              1: const FlexColumnWidth(1),
            },
            border: const TableBorder(
              verticalInside: BorderSide(color: PdfColors.grey800),
              bottom: BorderSide(color: PdfColors.grey800),
            ),
            children: [
              for (final record in creditAccount) ...[
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 2,
                        bottom: 1,
                        top: 10,
                      ),
                      child: Text(
                        record.account,
                        style: Theme.of(context).header2,
                      ),
                    ),
                  ],
                ),
                if (record.adjs != null)
                  for (final adj in record.adjs!)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Table(
                            columnWidths: {
                              0: const FlexColumnWidth(0.6),
                              1: const FlexColumnWidth(1.5),
                              2: const FlexColumnWidth(1),
                            },
                            children: [
                              if (adj.refType == "adj") ...[
                                TableRow(
                                  children: [
                                    Text("Agst Ref :"),
                                    adj.refNo != null
                                        ? Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}/${adj.refNo}',
                                          )
                                        : Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}',
                                          ),
                                    adj.principalAmount >= 0
                                        ? Text(
                                            '${adj.principalAmount.toStringAsFixed(2)} Dr',
                                            textAlign: TextAlign.end,
                                          )
                                        : Text(
                                            '${adj.principalAmount.abs().toStringAsFixed(2)} Cr',
                                            textAlign: TextAlign.end,
                                          )
                                  ],
                                ),
                              ] else if (adj.refType == "new")
                                TableRow(
                                  children: [
                                    Text("New Ref  :"),
                                    adj.refNo != null
                                        ? Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}/${adj.refNo}',
                                          )
                                        : Text(
                                            '${adj.date}/${adj.voucherNo ?? '---'}',
                                          ),
                                    adj.paidAmount >= 0
                                        ? Text(
                                            '${adj.paidAmount.toStringAsFixed(2)} Dr',
                                            textAlign: TextAlign.end,
                                          )
                                        : Text(
                                            '${adj.paidAmount.abs().toStringAsFixed(2)} Cr',
                                            textAlign: TextAlign.end,
                                          )
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: adj.paidAmount >= 0
                              ? Text(
                                  '${adj.paidAmount.toStringAsFixed(2)} Dr',
                                  textAlign: TextAlign.end,
                                )
                              : Text(
                                  '${adj.paidAmount.abs().toStringAsFixed(2)} Cr',
                                  textAlign: TextAlign.end,
                                ),
                        ),
                      ],
                    ),
                if (record.onAccount != null && record.onAccount != 0)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("On Account"),
                            record.onAccount! >= 0
                                ? Text(
                                    '${record.onAccount!.toStringAsFixed(2)} Dr',
                                    textAlign: TextAlign.end,
                                  )
                                : Text(
                                    '${record.onAccount!.abs().toStringAsFixed(2)} Cr',
                                    textAlign: TextAlign.end,
                                  ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: record.onAccount! >= 0
                            ? Text(
                                '${record.onAccount!.toStringAsFixed(2)} Dr',
                                textAlign: TextAlign.end,
                              )
                            : Text(
                                '${record.onAccount!.abs().toStringAsFixed(2)} Cr',
                                textAlign: TextAlign.end,
                              ),
                      ),
                    ],
                  ),
              ],
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 2,
                      bottom: 1,
                      top: 10,
                    ),
                    child: Text(
                      'Through',
                      style: Theme.of(context).header2,
                    ),
                  ),
                ],
              ),
              for (final record in debitAccount)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(record.account),
                          Text('${record.debit.toStringAsFixed(2)} Dr')
                        ],
                      ),
                    ),
                    Text('')
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total Amount : ', style: Theme.of(context).header2),
                Text('${data.amount.toStringAsFixed(2)} Cr')
              ],
            ),
          ),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}

FutureOr<Uint8List> buildContra(AccountVoucherData data) {
  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);

  pdf.addPage(
    MultiPage(
      pageTheme: PageTheme(
        pageFormat: PdfPageFormat(mm(210), mm(297), marginAll: mm(10)),
        theme: ThemeData(
          defaultTextStyle: TextStyle(
            fontSize: 11,
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
          // header2: TextStyle(
          //   fontSize: 11,
          //   font: Font.courier(),
          //   fontWeight: FontWeight.bold,
          //   fontBold: Font.courierBold(),
          // ),
          // header3: TextStyle(
          //   fontSize: 11,
          //   font: Font.courier(),
          //   color: PdfColors.grey800,
          // ),
          header4: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            font: Font.courier(),
            fontBold: Font.courierBold(),
            decoration: TextDecoration.underline,
            decorationColor: PdfColors.grey800,
          ),
        ),
      ),
      build: ((context) {
        return [
          buildVoucherHeader(
            context: context,
            orgName: data.orgName,
            branchInfo: data.branchInfo,
          ),
          buildDivider(height: 5),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.center,
            child: Text(
              data.voucherInfo.voucherName,
              style: Theme.of(context).header4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Voucher No  : ${data.voucherInfo.voucherNo}'),
                Text('Date  : ${data.voucherInfo.date}')
              ],
            ),
          ),
        ];
      }),
    ),
  );

  return pdf.save();
}
