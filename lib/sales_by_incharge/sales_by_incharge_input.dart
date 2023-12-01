import 'package:print_pdf/main.dart';

class SalesByInchargeRecord {
  final String name;
  final String code;
  final double taxableAmount;
  final double amount;

  SalesByInchargeRecord({
    this.name = "NA",
    this.code = "NA",
    required this.taxableAmount,
    required this.amount,
  });
}

class SalesByInchargeSummary {
  final double amount;
  final double taxableAmount;

  SalesByInchargeSummary({
    this.amount = 0.0,
    this.taxableAmount = 0.0,
  });
}

class SalesByInchargeInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String branches;
  final String? salesIncharges;
  final String? customerGroups;
  final String fromDate;
  final String toDate;
  final List<SalesByInchargeRecord> records;
  final SalesByInchargeSummary summary;

  SalesByInchargeInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.branches,
    required this.salesIncharges,
    required this.customerGroups,
    required this.fromDate,
    required this.toDate,
    required this.records,
    required this.summary,
  });
}

final salesInchargeData = SalesByInchargeInput(
  title: "Sales By Incharge",
  orgName: "VELAVAN MEDICAL",
  branchInfo: BranchInfo(
    displayName: "DP",
    gstNo: "33AANFV6837B1Z2w",
    licNo: "DLTN69201-20/21",
    phone: "044-4555555X",
    address: AddressInfo(city: "TUTY"),
    mobileNos: ["9988776655", "7689012345"],
    email: "dpbranch@gmail.com",
  ),
  branches: "DP, ETP BRANCH",
  salesIncharges: null,
  customerGroups: null,
  fromDate: "2022-11-20",
  toDate: "2023-11-23",
  records: [
    SalesByInchargeRecord(
      amount: 4170.24,
      taxableAmount: 3987.5,
      code: "15",
      name: "Anitta",
    ),
    SalesByInchargeRecord(
      amount: 4170.24,
      taxableAmount: 3987.526,
      code: "15",
      name: "Anitta",
    ),
  ],
  summary: SalesByInchargeSummary(
    taxableAmount: 100000000.5,
    amount: 55023450.50,
  ),
);
