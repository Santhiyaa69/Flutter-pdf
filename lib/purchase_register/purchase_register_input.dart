import '../main.dart';

class PurchaseRegisterSummary {
  final double billAmount;
  final double cashAmount;
  final double bankAmount;
  final double creditAmount;

  PurchaseRegisterSummary({
    this.billAmount = 0.0,
    this.cashAmount = 0.0,
    this.bankAmount = 0.0,
    this.creditAmount = 0.0,
  });
}

class PurchaseRegisterRecord {
  final String particulars;
  final String? branch;
  final double cashAmount;
  final double bankAmount;
  final double creditAmount;
  final double amount;

  PurchaseRegisterRecord({
    required this.particulars,
    this.branch,
    this.cashAmount = 0.0,
    this.bankAmount = 0.0,
    this.creditAmount = 0.0,
    this.amount = 0.0,
  });
}

class PurchaseRegisterInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String branches;
  final String? vendor;
  final String? paymentAccounts;
  final String? paymentMode;
  final List<PurchaseRegisterRecord> records;
  final PurchaseRegisterSummary summary;
  // final String view;
  final String? group;

  PurchaseRegisterInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.branches,
    this.vendor,
    this.paymentAccounts,
    this.paymentMode,
    required this.records,
    required this.summary,
    // required this.view,
    this.group,
  });
}

class PurchaseRegisterDetailRecord {
  final String date;
  final String? vendor;
  final String voucherType;
  final String voucherNo;
  final String? refNo;
  final double cashAmount;
  final double bankAmount;
  final double creditAmount;
  final double amount;

  PurchaseRegisterDetailRecord({
    required this.date,
    this.vendor,
    required this.voucherType,
    required this.voucherNo,
    this.refNo,
    this.cashAmount = 0.0,
    this.bankAmount = 0.0,
    this.creditAmount = 0.0,
    this.amount = 0.0,
  });
}

class PurchaseRegisterDetailInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String branches;
  final String? vendor;
  final String? paymentAccounts;
  final String? paymentMode;
  final List<PurchaseRegisterDetailRecord> records;
  final PurchaseRegisterSummary summary;

  PurchaseRegisterDetailInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.branches,
    this.vendor,
    this.paymentAccounts,
    this.paymentMode,
    required this.records,
    required this.summary,
  });
}

final purchaseRegDetailData = PurchaseRegisterDetailInput(
  title: 'Purchase Register Report',
  orgName: 'TEST ORG',
  branchInfo: BranchInfo(
    displayName: "ERP BRANCH",
    gstNo: "",
    address: AddressInfo(address: "12,KTC NAGAR", city: "TUTY"),
  ),
  fromDate: "2021-01-01",
  toDate: "2021-01-02",
  branches: "DP ROAD  BRANCH",
  records: [
    PurchaseRegisterDetailRecord(
      date: "2021-12-01",
      voucherType: "PURCHASE",
      voucherNo: "DP132659",
      vendor: null,
      refNo: null,
      amount: 644,
      cashAmount: 644,
      bankAmount: 0,
      creditAmount: 0,
    ),
    PurchaseRegisterDetailRecord(
      date: "2021-12-01",
      voucherType: "PURCHASE",
      voucherNo: "DP132659",
      vendor: "dia",
      refNo: "P1",
      amount: 832.0,
      cashAmount: 832,
      bankAmount: 0,
      creditAmount: 0,
    ),
    PurchaseRegisterDetailRecord(
      date: "2021-12-01",
      voucherType: "DEBIT NOTE",
      voucherNo: "VES23241559",
      vendor: "KEERTHI MEENA TRADERS",
      refNo: "555/23-24",
      amount: 74125896.00,
      cashAmount: 518,
      bankAmount: 0,
      creditAmount: 0,
    ),
  ],
  summary: PurchaseRegisterSummary(
    billAmount: 1994741.0,
    cashAmount: 1994.0,
    bankAmount: 71014580,
    creditAmount: 0,
  ),
);

final purchaseRegData = PurchaseRegisterInput(
  title: 'Purchase Register Report',
  orgName: 'TEST ORG',
  branchInfo: BranchInfo(
    displayName: "ERP BRANCH",
    gstNo: "",
    address: AddressInfo(),
  ),
  fromDate: "2021-01-01",
  toDate: "2021-01-02",
  branches: "DP ROAD  BRANCH",
  // view: "daily",
  group: "branch",
  records: [
    PurchaseRegisterRecord(
      particulars: "2023-11-01",
      branch: "DP ROAD",
      amount: 1994741,
    ),
    // PurchaseRegisterRecord(
    //   particulars: "2023-11-22",
    //   branch: "DP ROAD",
    //   bankAmount: 10,
    //   cashAmount: 40,
    //   amount: 50,
    // ),
    // PurchaseRegisterRecord(
    //   particulars: "2023-11-22",
    //   branch: "DP ROAD",
    //   bankAmount: 10,
    //   cashAmount: 90,
    //   amount: 100,
    // ),
    // PurchaseRegisterRecord(
    //   particulars: "2023-11-22",
    //   branch: "DP ROAD",
    //   bankAmount: 10,
    //   cashAmount: 190,
    //   amount: 200,
    // ),
    // PurchaseRegisterRecord(
    //   particulars: "2023-11-22",
    //   branch: "DP ROAD",
    //   bankAmount: 500,
    //   cashAmount: 4500,
    //   amount: 5000,
    // ),
  ],
  summary: PurchaseRegisterSummary(
    billAmount: 1994741.0,
    cashAmount: 1994.0,
    bankAmount: 71014580,
    creditAmount: 0,
  ),
);
