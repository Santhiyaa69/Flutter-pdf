import '../main.dart';

class CustomerWiseSalesRecord {
  final String name;
  final String? mobile;
  final double total;

  CustomerWiseSalesRecord({
    required this.name,
    this.mobile,
    required this.total,
  });
}

class CustomerWiseSalesInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String branches;
  final String? customers;
  final List<CustomerWiseSalesRecord> records;
  final double total;
  final String fromDate;
  final String toDate;

  CustomerWiseSalesInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.branches,
    this.customers,
    required this.records,
    required this.total,
    required this.fromDate,
    required this.toDate,
  });
}

class CustomerWiseSalesDetailRecord {
  final String date;
  final String branch;
  final String voucherType;
  final String voucherNo;
  final String? refNo;
  final double amount;

  CustomerWiseSalesDetailRecord({
    required this.date,
    required this.branch,
    required this.voucherType,
    required this.voucherNo,
    this.refNo,
    required this.amount,
  });
}

class CustomerWiseSalesDetailInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String branches;
  final String? customers;
  final List<CustomerWiseSalesDetailRecord> records;
  final double total;
  final String fromDate;
  final String toDate;

  CustomerWiseSalesDetailInput({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.branches,
    this.customers,
    required this.records,
    required this.total,
    required this.fromDate,
    required this.toDate,
  });
}

final cwsDetaildata = CustomerWiseSalesDetailInput(
  title: "Customer Wise Sales",
  orgName: "VELAVAN MEDICAL",
  branchInfo: BranchInfo(
    displayName: "DP",
    gstNo: "33AANFV6837B1Z2w",
    address: AddressInfo(),
  ),
  branches: "DP, ETP BRANCH",
  customers: null,
  records: [
    CustomerWiseSalesDetailRecord(
      date: "2023-01-21",
      branch: "EP BRANCH",
      amount: 5,
      voucherNo: "EPSL22231",
      voucherType: "SALE",
    ),
    CustomerWiseSalesDetailRecord(
      date: "2023-01-21",
      branch: "EP BRANCH",
      refNo: "SL2",
      amount: 15,
      voucherNo: "EPSL22232",
      voucherType: "SALE",
    ),
  ],
  total: 74125896,
  fromDate: "2021-02-17",
  toDate: "2021-02-17",
);

final cwsData = CustomerWiseSalesInput(
  title: "Customer Wise Sales",
  orgName: "VELAVAN MEDICAL",
  branchInfo: BranchInfo(
    displayName: "DP",
    gstNo: "33AANFV6837B1Z2w",
    address: AddressInfo(),
  ),
  branches: "DP, ETP BRANCH",
  customers: "Anitta&Co",
  records: [
    CustomerWiseSalesRecord(
      name: 'Sai',
      total: 292.5,
    ),
    CustomerWiseSalesRecord(
      name: 'Sakthi',
      mobile: "7418523690",
      total: 292.5,
    ),
    CustomerWiseSalesRecord(
      name: 'Sai',
      total: 292.5,
    )
  ],
  total: 74125896,
  fromDate: "2021-02-17",
  toDate: "2021-02-17",
);
