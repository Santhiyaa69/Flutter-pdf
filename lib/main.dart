import 'package:flutter/material.dart';

import 'package:printing/printing.dart';

import 'common/branch_info.dart';
import './pdf_templates.dart';

const double point = 1.0;
const double inch = 72.0;
const double cm = inch / 2.54;
double mm(double pt) {
  return pt * 72.0 / 25.4;
}

class PartyInfo {
  final String? name;
  final String? gstNo;
  final AddressInfo? address;
  final List<String>? mobileNos;

  PartyInfo({
    this.name,
    this.gstNo,
    this.address,
    this.mobileNos,
  });
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: ElevatedButton(
        //   child: const Text("Print"),
        //   onPressed: () {
        //     print("data");
        //   },
        // ),
        child: PdfPreview(
          build: (_) {
            return
                // salesByIncharge(salesInchargeData);
                // stockAnalysis(stockAnalysisData);
                // expiryAnalysis(expiryAnalysisData);

                // customerWiseSales(cwsData);
                // customerWiseSalesDetail(cwsDetaildata);

                // saleRegisterDetail(saleRegDetailData);
                // saleRegisterDetailMode(saleRegDetailData);
                // saleRegisterGroupView(saleRegData);
                // saleRegisterGroupViewDetailMode(saleRegData);

                // purchaseRegisterDetail(purchaseRegDetailData);
                // purchaseRegisterDetailMode(purchaseRegDetailData);
                // purchaseRegisterGroupView(purchaseRegData);
                // purchaseRegisterGroupViewDetailMode(purchaseRegData);

                // reorderAnalysis(reorderAnalysisData);

                // buildSaleLayoutA(saleData, saleLayoutAConfig);
                // buildSaleLayoutB(saleData, saleLayoutBConfig);
                buildSaleLayoutA6(saleData, saleLayoutA6Config);
            // buildSaleQuotationLayout(
            //     saleQuotationData, saleQuotationConfig);
            // buildPurchaseLayout(purchaseData, purchaseConfig);
            //     buildStockTransferLayout(
            //   stockTransferData,
            //   stockTransferConfig,
            // );

            // buildPayment(paymentData);
            // buildReceipt(receiptData);
          },
        ),
      ),
    );
  }
}
