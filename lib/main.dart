import 'package:flutter/material.dart';
import 'package:print_pdf/vouchers/sale_78mm.dart';
import 'package:print_pdf/vouchers/sale_input.dart';
import 'package:print_pdf/vouchers/sales_a4.dart';

import 'package:printing/printing.dart';

import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

// import 'customer_wise_sales/customer_wise_sales.dart';
// import 'customer_wise_sales/customer_wise_sales_detail.dart';
// import 'customer_wise_sales/customer_wise_sales_input.dart';

// import 'sales_by_incharge/sales_by_incharge.dart';
// import 'sales_by_incharge/sales_by_incharge_input.dart';

// import 'expiry_analysis/expiry_analysis.dart';
// import 'expiry_analysis/expiry_analysis_input.dart';

// import 'stock_analysis/stock_analysis.dart';
// import 'stock_analysis/stock_analysis_input.dart';

import 'sale_register/sale_register_detail.dart';
// import 'sale_register/sale_register_view.dart';
import 'sale_register/sale_register_input.dart';

// import 'purchase_register/purchase_register.dart';
// import 'purchase_register/purchase_register_detail.dart';
// import 'purchase_register/purchase_register_input.dart';

import 'reorder_analysis/reorder_analysis.dart';
import 'reorder_analysis/reorder_analysis_input.dart';

const double point = 1.0;
const double inch = 72.0;
const double cm = inch / 2.54;
double mm(double pt) {
  return pt * 72.0 / 25.4;
}

class AddressInfo {
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;

  AddressInfo({
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
  });
}

class BranchInfo {
  final String displayName;
  final String gstNo;
  final String? licNo;
  final String? phone;
  final AddressInfo address;
  final List<String>? mobileNos;
  final String? email;

  BranchInfo({
    required this.displayName,
    required this.gstNo,
    this.licNo,
    this.phone,
    required this.address,
    this.mobileNos,
    this.email,
  });
}

class VoucherInfo {
  final String voucherNo;
  final String date;
  final String time;
  final String? refNo;
  final String voucherName;
  final String voucherType;

  VoucherInfo({
    required this.voucherNo,
    required this.date,
    required this.time,
    this.refNo,
    required this.voucherName,
    required this.voucherType,
  });
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

                // sale78mm(saleData);
                // buildlayoutAconfig(saleData, salePdfLayoutAConfig);
                buildlayoutB(saleData, salePdfLayoutBConfig);
          },
        ),
      ),
    );
  }
}
