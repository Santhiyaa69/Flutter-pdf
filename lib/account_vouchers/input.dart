import '../common/branch_info.dart';
import '../common/voucher_info.dart';

class PendingAdjustment {
  final String date;
  final String? voucherNo;
  final String? refNo;
  final String refType;
  final double principalAmount;
  final double paidAmount;

  PendingAdjustment({
    required this.date,
    this.voucherNo,
    this.refNo,
    required this.refType,
    required this.principalAmount,
    required this.paidAmount,
  });
}

class AccountTransaction {
  final String account;
  final double credit;
  final double debit;
  final double? onAccount;
  final List<PendingAdjustment>? adjs;

  AccountTransaction({
    required this.account,
    required this.credit,
    required this.debit,
    this.onAccount,
    this.adjs,
  });
}

class AccountVoucherData {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final VoucherInfo voucherInfo;
  final String? description;
  final List<AccountTransaction> accountTransactions;
  final double amount;

  AccountVoucherData({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.voucherInfo,
    this.description,
    required this.accountTransactions,
    required this.amount,
  });
}

final paymentData = AccountVoucherData(
  title: "Payment",
  orgName: "TEST ORG",
  branchInfo: BranchInfo(
    displayName: "DP ROAD",
    gstNo: "33AIVPV0468N1ZC",
    phone: null,
    mobileNos: ["9842019102", "7373776102"],
    email: "support@auditplus.io",
    address: AddressInfo(
      address: "2nd FLOOR,45,GIN FACTORY ROAD",
      city: "TUTICORIN",
      pincode: "628002",
    ),
  ),
  voucherInfo: VoucherInfo(
    voucherNo: "MBBB232427585555",
    date: "2023-11-21",
    time: "06.07 P.M",
    refNo: "ST1",
    voucherName: "PAY",
    voucherType: "payment",
  ),
  accountTransactions: [
    AccountTransaction(
      account: "TEST VENDOR",
      credit: 0,
      debit: 500,
      onAccount: 55,
      adjs: [
        PendingAdjustment(
          date: "2023-09-27",
          refType: "new",
          principalAmount: 0,
          paidAmount: 200,
        ),
        PendingAdjustment(
          date: "2023-09-26",
          refType: "adj",
          voucherNo: "EP23241",
          principalAmount: -245,
          paidAmount: 245,
        ),
      ],
    ),
    AccountTransaction(
      account: "Cash",
      credit: 245,
      debit: 0,
    ),
    AccountTransaction(
      account: "TMB",
      credit: 255,
      debit: 0,
    ),
  ],
  amount: 500,
  description: 'pay',
);

final receiptData = AccountVoucherData(
  title: "Receipt",
  orgName: "TEST ORG",
  branchInfo: BranchInfo(
    displayName: "DP ROAD",
    gstNo: "33AIVPV0468N1ZC",
    phone: null,
    mobileNos: ["9842019102", "7373776102"],
    email: "support@auditplus.io",
    address: AddressInfo(
      address: "2nd FLOOR,45,GIN FACTORY ROAD",
      city: "TUTICORIN",
      pincode: "628002",
    ),
  ),
  voucherInfo: VoucherInfo(
    voucherNo: "MBBB232427585555",
    date: "2023-11-21",
    time: "06.07 P.M",
    refNo: "ST1",
    voucherName: "RECEIPT",
    voucherType: "receipt",
  ),
  accountTransactions: [
    AccountTransaction(
      account: "cust3",
      credit: 20,
      debit: 0,
      onAccount: -50,
      adjs: [
        PendingAdjustment(
          date: "2023-09-27",
          refType: "new",
          principalAmount: 10,
          paidAmount: -10,
          voucherNo: "DPJ271",
        ),
        PendingAdjustment(
          date: "2023-09-26",
          refType: "adj",
          voucherNo: "DP2223162218",
          principalAmount: 21,
          paidAmount: -20,
        ),
      ],
    ),
    AccountTransaction(
      account: "Cash",
      credit: 0,
      debit: 30,
    ),
  ],
  amount: 30,
  description: 'pay',
);
