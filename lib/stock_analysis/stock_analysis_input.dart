import 'package:print_pdf/main.dart';

class StockAnalysisRecord {
  final String? name;
  final int closing;
  final double value;

  StockAnalysisRecord({
    this.name,
    required this.closing,
    required this.value,
  });
}

class StockAnalysisSummary {
  final double closing;
  final double value;

  StockAnalysisSummary({
    this.closing = 0,
    this.value = 0.0,
  });
}

class StockAnalysisInput {
  final String asOnDate;
  final String printedOn;
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String branches;
  final String group;
  final String? inventory;
  final String? section;
  final String? manufacturer;
  final List<StockAnalysisRecord> records;
  final StockAnalysisSummary summary;

  StockAnalysisInput({
    required this.asOnDate,
    required this.printedOn,
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.branches,
    this.group = "Inventory",
    this.inventory,
    this.section,
    this.manufacturer,
    required this.records,
    required this.summary,
  });
}

final stockAnalysisData = StockAnalysisInput(
  asOnDate: "2023-10-07",
  printedOn: "",
  title: "Stock Analysis Report",
  orgName: "Test ORG",
  branchInfo: BranchInfo(
    displayName: "",
    gstNo: "",
    address: AddressInfo(),
  ),
  branches: "MAIN BRANCH",
  group: "Inventory",
  inventory: null,
  section: null,
  manufacturer: null,
  records: [
    StockAnalysisRecord(name: "Choco Drink", closing: -15, value: 217.9),
    StockAnalysisRecord(name: "Dolo 650", closing: 100, value: 1200.0),
    StockAnalysisRecord(name: "Ziten Tablet", closing: 100, value: 1200.0),
    StockAnalysisRecord(name: "Ziten Tablet", closing: 2270, value: 17750.0),
    StockAnalysisRecord(name: "crocin 500", closing: 10000, value: 10000.0),
    StockAnalysisRecord(name: "dolo 500", closing: 35360, value: 37554.4),
  ],
  summary: StockAnalysisSummary(
    value: 67722.3,
    closing: 38845.0,
  ),
);
