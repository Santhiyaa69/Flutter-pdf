import '../main.dart';

class SaleRegisterSummary {
  final double billAmount;
  final double cashAmount;
  final double eftAmount;
  final double bankAmount;
  final double creditAmount;

  SaleRegisterSummary({
    this.billAmount = 0.0,
    this.cashAmount = 0.0,
    this.eftAmount = 0.0,
    this.bankAmount = 0.0,
    this.creditAmount = 0.0,
  });
}

class SaleRegisterRecord {
  final String particulars;
  final String? branch;
  final double cashAmount;
  final double eftAmount;
  final double bankAmount;
  final double creditAmount;
  final double amount;

  SaleRegisterRecord({
    required this.particulars,
    this.branch,
    this.cashAmount = 0.0,
    this.eftAmount = 0.0,
    this.bankAmount = 0.0,
    this.creditAmount = 0.0,
    this.amount = 0.0,
  });
}

class SaleRegisterInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String branches;
  final String? customer;
  final String? paymentAccounts;
  final String? paymentMode;
  final List<SaleRegisterRecord> records;
  final SaleRegisterSummary summary;
  // final String view;
  final String? group;

  SaleRegisterInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.branches,
    this.customer,
    this.paymentAccounts,
    this.paymentMode,
    required this.records,
    required this.summary,
    // required this.view,
    this.group,
  });
}

class SaleRegisterDetailRecord {
  final String date;
  final String? customer;
  final String voucherType;
  final String voucherNo;
  final String? refNo;
  final double cashAmount;
  final double eftAmount;
  final double bankAmount;
  final double creditAmount;
  final double amount;

  SaleRegisterDetailRecord({
    required this.date,
    this.customer,
    required this.voucherType,
    required this.voucherNo,
    this.refNo,
    this.cashAmount = 0.0,
    this.eftAmount = 0.0,
    this.bankAmount = 0.0,
    this.creditAmount = 0.0,
    this.amount = 0.0,
  });
}

class SaleRegisterDetailInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String fromDate;
  final String toDate;
  final String branches;
  final String? customer;
  final String? paymentAccounts;
  final String? paymentMode;
  final List<SaleRegisterDetailRecord> records;
  final SaleRegisterSummary summary;

  SaleRegisterDetailInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.fromDate,
    required this.toDate,
    required this.branches,
    this.customer,
    this.paymentAccounts,
    this.paymentMode,
    required this.records,
    required this.summary,
  });
}

final saleRegDetailData = SaleRegisterDetailInput(
  title: 'Sale Register Report',
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
    SaleRegisterDetailRecord(
      date: "2021-12-01",
      voucherType: "SALE",
      voucherNo: "DP132659",
      customer: null,
      refNo: null,
      amount: 644,
      cashAmount: 644,
      bankAmount: 0,
      eftAmount: 0,
      creditAmount: 0,
    ),
    SaleRegisterDetailRecord(
      date: "2021-12-01",
      voucherType: "SALE",
      voucherNo: "DP132659",
      customer: "dia",
      refNo: "SL1",
      amount: 832.0,
      cashAmount: 832,
      bankAmount: 0,
      eftAmount: 0,
      creditAmount: 0,
    ),
    SaleRegisterDetailRecord(
      date: "2021-12-01",
      voucherType: "SALE",
      voucherNo: "DP132659",
      customer: null,
      refNo: null,
      amount: 518.0,
      cashAmount: 518,
      bankAmount: 0,
      eftAmount: 0,
      creditAmount: 0,
    ),
  ],
  summary: SaleRegisterSummary(
    billAmount: 1994741.0,
    cashAmount: 1994.0,
    eftAmount: 0,
    bankAmount: 71014580,
    creditAmount: 74125896,
  ),
);

final saleRegData = SaleRegisterInput(
  title: 'Sale Register Report',
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
    SaleRegisterRecord(
      particulars: "2023-11-22",
      branch: "DP ROAD",
      amount: 25,
    ),
    SaleRegisterRecord(
      particulars: "2023-11-22",
      branch: "DP ROAD",
      amount: 50,
    ),
    SaleRegisterRecord(
      particulars: "2023-11-22",
      branch: "DP ROAD",
      amount: 100,
    ),
    SaleRegisterRecord(
      particulars: "2023-11-22",
      branch: "DP ROAD",
      amount: 200,
    ),
    SaleRegisterRecord(
      particulars: "2023-11-22",
      branch: "DP ROAD",
      amount: 5000,
    ),
  ],
  summary: SaleRegisterSummary(
    billAmount: 1994741.0,
    cashAmount: 1994.0,
    eftAmount: 0,
    bankAmount: 71014580,
    creditAmount: 0,
  ),
);
