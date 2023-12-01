import 'package:print_pdf/main.dart';

class ExpiryAnalysisRecord {
  final String expiry;
  final String particulars;
  final String? batchNo;
  final int closing;
  final double assetValue;

  ExpiryAnalysisRecord({
    required this.expiry,
    required this.particulars,
    this.batchNo,
    required this.closing,
    required this.assetValue,
  });
}

class ExpiryAnalysisSummary {
  final double closing;
  final double assetValue;

  ExpiryAnalysisSummary({
    this.closing = 0.0,
    this.assetValue = 0.0,
  });
}

class ExpiryAnalysisInput {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String branches;
  final List<ExpiryAnalysisRecord> records;
  final ExpiryAnalysisSummary summary;
  final String toDate;
  final String? fromDate;

  ExpiryAnalysisInput({
    required this.title,
    required this.orgName,
    required this.branches,
    required this.branchInfo,
    required this.records,
    required this.summary,
    required this.toDate,
    this.fromDate,
  });
}

final expiryAnalysisData = ExpiryAnalysisInput(
  title: "Expiry Analysis Report",
  orgName: "Test Org",
  branches: "EP BRANCH, MAIN BRANCH",
  branchInfo:
      BranchInfo(displayName: "DP ROAD", gstNo: "", address: AddressInfo()),
  records: [
    ExpiryAnalysisRecord(
      particulars: "munch",
      expiry: "2025-10-01",
      closing: 37,
      assetValue: 148,
    ),
  ],
  summary: ExpiryAnalysisSummary(
    closing: 292,
    assetValue: 143820.5,
  ),
  fromDate: null,
  toDate: "2028-10-01",
);
