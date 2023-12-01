import '../main.dart';

class ReorderAnalysisRecord {
  final String inventory;
  final int orderLevel;
  final int orderQty;
  final int stock;
  final String unit;

  ReorderAnalysisRecord({
    required this.inventory,
    required this.orderLevel,
    required this.orderQty,
    required this.stock,
    required this.unit,
  });
}

class ReorderAnalysis {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final String branches;
  final String group;
  final Map<String, List<ReorderAnalysisRecord>> records;

  ReorderAnalysis({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.branches,
    required this.group,
    required this.records,
  });
}

final reorderAnalysisData = ReorderAnalysis(
  title: "Reorder Analysis",
  orgName: "TEST ORG",
  branchInfo: BranchInfo(
    displayName: "ERP BRANCH",
    gstNo: "",
    address: AddressInfo(),
  ),
  branches: "DP ROAD BRANCH",
  group: "vendor",
  records: {
    "Not Available": [
      ReorderAnalysisRecord(
        inventory: "Vicks",
        orderLevel: 2,
        orderQty: 5,
        stock: 10,
        unit: "PCS",
      ),
      ReorderAnalysisRecord(
        inventory: "Halls",
        orderLevel: 1,
        orderQty: 10,
        stock: 2,
        unit: "PCS",
      )
    ],
    "Rishi Trades": [
      ReorderAnalysisRecord(
        inventory: "Strepsils",
        orderLevel: 3,
        orderQty: 20,
        stock: 2,
        unit: "PCS",
      )
    ],
  },
);
