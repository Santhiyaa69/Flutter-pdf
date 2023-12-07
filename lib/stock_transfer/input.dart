import '../common/branch_info.dart';
import '../common/voucher_info.dart';
import '../sale/input.dart';

class StockTransferItem {
  final String name;
  final String unit;
  final double qty;
  final double precision;
  final double mrp;
  final String? batchNo;
  final String? expiry;

  StockTransferItem({
    required this.name,
    required this.unit,
    required this.qty,
    required this.precision,
    required this.mrp,
    this.batchNo,
    this.expiry,
  });
}

class StockTransferData {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final BranchInfo altBranchInfo;
  final VoucherInfo voucherInfo;
  final List<StockTransferItem> items;

  StockTransferData({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.altBranchInfo,
    required this.voucherInfo,
    required this.items,
  });
}

class StockTransferConfig {
  final double pageWidth;
  final double pageHeight;
  final double margin;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationMobile;
  final bool showOrganizationEmail;
  final bool showGstNo;
  final bool showLicNo;
  final bool showVoucherInfo;
  final bool showAlternateBranchInfo;

  final ColumnConfig item;
  final ColumnConfig batchNo;
  final ColumnConfig expiry;
  final ColumnConfig qty;
  final ColumnConfig mrp;

  StockTransferConfig({
    required this.pageWidth,
    required this.pageHeight,
    required this.margin,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationMobile = false,
    this.showOrganizationEmail = false,
    this.showGstNo = false,
    this.showLicNo = false,
    this.showVoucherInfo = false,
    this.showAlternateBranchInfo = false,
    required this.item,
    required this.batchNo,
    required this.expiry,
    required this.qty,
    required this.mrp,
  });
}

final stockTransferData = StockTransferData(
  title: "Stock Transfer",
  orgName: "VELAVAN HYPERMARKET BOOKS & STATIONERY",
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
  altBranchInfo: BranchInfo(
    displayName: "EP ROAD",
    gstNo: "33AIVPV0468N1ZC",
    phone: "04617895641",
    mobileNos: ["9842019102", "7373776102"],
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
    voucherName: "Stock Transfer",
    voucherType: "voucher_type:stock_transfer",
  ),
  items: [
    StockTransferItem(
      name: "strepsils",
      precision: 2,
      qty: 5,
      mrp: 5,
      batchNo: "S1",
      unit: "pcs",
    ),
    StockTransferItem(
      name: "COTTON ROLL",
      precision: 3,
      qty: 5,
      mrp: 200,
      batchNo: "CR01",
      unit: "Kilogram",
    ),
  ],
);

final stockTransferConfig = StockTransferConfig(
  pageWidth: 148,
  pageHeight: 105,
  margin: 5,
  showOrganizationAddress: true,
  showOrganizationPhone: true,
  showOrganizationMobile: false,
  showOrganizationEmail: true,
  showGstNo: true,
  showVoucherInfo: true,
  showAlternateBranchInfo: true,
  item: ColumnConfig(
    width: 1.5,
    label: "PARTICULARS",
  ),
  batchNo: ColumnConfig(
    width: 1,
    label: "BATCH",
  ),
  expiry: ColumnConfig(
    width: 1,
    label: "EXPIRY",
  ),
  qty: ColumnConfig(
    width: 1,
    label: "QTY",
  ),
  mrp: ColumnConfig(
    width: 1,
    label: "MRP",
  ),
);
