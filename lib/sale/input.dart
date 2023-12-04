import '../common/branch_info.dart';
import '../common/voucher_info.dart';
import '../main.dart';

class DeliveryInfo {
  final String? date;
  final String? transport;
  DeliveryInfo({
    this.date,
    this.transport,
  });
}

class AmountInfo {
  final String mode;
  final double amount;

  AmountInfo({
    required this.mode,
    required this.amount,
  });
}

class PartyOutstanding {
  final double previousBal;
  final double totalOutstanding;

  PartyOutstanding({
    this.previousBal = 0.0,
    this.totalOutstanding = 0.0,
  });
}

class SaleItem {
  final String name;
  final int precision;
  final double qty;
  final String unit;
  final double mrp;
  final double rate;
  final String? batchNo;
  final String? rack;
  final String? expiry;
  final String? hsnCode;
  final double taxableValue;
  final double taxRatio;
  final double cgstAmount;
  final double sgstAmount;
  final double igstAmount;
  final double cessAmount;
  final AmountInfo? disc;
  final double dAmount;
  final double reduction;
  final String? salesManName;
  final String? salesManCode;

  SaleItem({
    required this.name,
    required this.precision,
    required this.qty,
    required this.unit,
    required this.mrp,
    required this.rate,
    this.batchNo,
    this.rack,
    this.expiry,
    this.hsnCode,
    required this.taxableValue,
    required this.taxRatio,
    this.cgstAmount = 0.0,
    this.sgstAmount = 0.0,
    this.igstAmount = 0.0,
    this.cessAmount = 0.0,
    this.disc,
    this.dAmount = 0.0,
    this.reduction = 0.0,
    this.salesManCode,
    this.salesManName,
  });
}

class TaxSummary {
  final double ratio;
  final double value;
  final double sgst;
  final double cgst;
  final double igst;
  final double cess;

  TaxSummary({
    required this.ratio,
    required this.value,
    required this.sgst,
    required this.cgst,
    required this.igst,
    required this.cess,
  });
}

class SaleData {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final VoucherInfo voucherInfo;
  final PartyInfo partyInfo;
  final String? patientName;
  final String? doctorName;
  final bool lut;
  final String billedBy;
  final String? description;
  final DeliveryInfo deliveryInfo;
  final List<SaleItem> items;
  final List<TaxSummary> taxSummary;
  final PartyOutstanding partyOutstanding;
  final String? salesManName;
  final double discount;
  final double rounded;
  final double accountAdjustment;
  final double shippingCharge;
  final double netAmount;
  final String? qrCode;

  SaleData({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.voucherInfo,
    required this.partyInfo,
    this.patientName,
    this.doctorName,
    required this.deliveryInfo,
    required this.items,
    required this.taxSummary,
    required this.partyOutstanding,
    this.salesManName,
    required this.discount,
    required this.rounded,
    required this.accountAdjustment,
    required this.shippingCharge,
    required this.netAmount,
    required this.lut,
    required this.billedBy,
    this.description,
    this.qrCode,
  });
}

class ColumnConfig {
  final double width;
  final String label;

  ColumnConfig({
    required this.width,
    required this.label,
  });
}

class SaleLayoutAConfig {
  final double pageWidth;
  final double margin;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationMobile;
  final bool showOrganizationEmail;
  final bool showGstNo;
  final bool showLicNo;
  final String title;
  final ColumnConfig item;
  final ColumnConfig qty;
  final ColumnConfig mrp;
  final ColumnConfig rate;
  final ColumnConfig amount;
  final ColumnConfig discount;
  final List<String>? termsAndConditions;
  final String? greetings;

  SaleLayoutAConfig({
    required this.margin,
    required this.pageWidth,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationMobile = false,
    this.showOrganizationEmail = false,
    this.showGstNo = false,
    this.showLicNo = false,
    required this.title,
    required this.item,
    required this.qty,
    required this.mrp,
    required this.rate,
    required this.amount,
    required this.discount,
    this.termsAndConditions,
    this.greetings,
  });
}

class BankDetails {
  final bool enabled;
  final String bankName;
  final String acName;
  final String acNo;
  final String ifscCode;
  final String panNo;

  BankDetails({
    this.enabled = false,
    required this.bankName,
    required this.acName,
    required this.acNo,
    required this.ifscCode,
    required this.panNo,
  });
}

class SaleLayoutBConfig {
  final double pageWidth;
  final double pageHeight;
  final double margin;
  final String orientation;
  final bool showOrganizationName;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationDetails;
  final bool showPartyInfo;
  final bool showVoucherInfo;
  final bool showContactInfo; //[patient and doctor]
  final ColumnConfig serialNo;
  final ColumnConfig item;
  final ColumnConfig hsnCode;
  final ColumnConfig qty;
  final ColumnConfig mrp;
  final ColumnConfig rate;
  final ColumnConfig unit;
  final ColumnConfig taxableValue;
  final ColumnConfig taxRatio;
  final ColumnConfig taxAmount;
  final ColumnConfig discount;
  final ColumnConfig amount;
  final bool showGSTSummary;
  final BankDetails? showBankDetails;
  final bool showBillDetails;
  final bool showBalanceDetails;
  final List<String>? termsAndConditions;
  final String? greetings;

  SaleLayoutBConfig({
    required this.pageWidth,
    required this.pageHeight,
    required this.margin,
    this.orientation = "landscape",
    this.showOrganizationName = false,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationDetails = false,
    this.showPartyInfo = false,
    this.showVoucherInfo = false,
    this.showContactInfo = false,
    required this.serialNo,
    required this.item,
    required this.hsnCode,
    required this.qty,
    required this.mrp,
    required this.rate,
    required this.unit,
    required this.taxableValue,
    required this.taxRatio,
    required this.taxAmount,
    required this.discount,
    required this.amount,
    this.showGSTSummary = false,
    this.showBankDetails,
    this.showBillDetails = false,
    this.showBalanceDetails = false,
    this.termsAndConditions,
    this.greetings,
  });
}

class SaleLayoutA6Config {
  final double pageWidth;
  final double pageHeight;
  final double margin;
  final bool showOrganizationName;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationDetails;
  final bool showVoucherInfo;
  final bool showContactInfo; //[patient and doctor]

  final ColumnConfig item;
  final ColumnConfig rack;
  final ColumnConfig batchNo;
  final ColumnConfig expiry;
  final ColumnConfig qty;
  final ColumnConfig mrp;
  final ColumnConfig rate;
  final ColumnConfig discount;
  final ColumnConfig amount;
  final bool showGSTSummary;
  final bool showBillDetails;

  SaleLayoutA6Config({
    required this.pageWidth,
    required this.pageHeight,
    required this.margin,
    this.showOrganizationName = false,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationDetails = false,
    this.showVoucherInfo = false,
    this.showContactInfo = false,
    required this.item,
    required this.rack,
    required this.batchNo,
    required this.expiry,
    required this.qty,
    required this.mrp,
    required this.rate,
    required this.amount,
    required this.discount,
    this.showGSTSummary = false,
    this.showBillDetails = false,
  });
}

// final saleData = SaleData(
//   title: "Sale",
//   orgName: "MA MEDICALS",
//   branchInfo: BranchInfo(
//     displayName: "DP ROAD",
//     gstNo: "33ANEPA4609G3ZI",
//     licNo: null,
//     phone: null,
//     email: null,
//     mobileNos: ["8575757546"],
//     address: AddressInfo(
//       address:
//           "2/790,South Facing Ground Floor,Thiruvallur High Road,Gandhi Nagar",
//       city: "Chennai",
//       pincode: "600052",
//     ),
//   ),
//   voucherInfo: VoucherInfo(
//     voucherNo: "BAS23241",
//     date: "2023-09-30",
//     time: "2023-09-26T08:19:25.692492600Z",
//     refNo: null,
//     voucherName: "Sale",
//     voucherType: "voucher_type:sale",
//   ),
//   partyInfo: PartyInfo(
//     name: "VELAVAN HYPER MARKET PVT LTD",
//     mobileNos: ["9566700835"],
//     gstNo: "33AAHCV6142J1Z7",
//     address: AddressInfo(
//       address: "51 GIN FACTORY ROAD THOOTHUKUDI",
//       pincode: "628002",
//       state: "TAMILNADU",
//       country: "INDIA",
//     ),
//   ),
//   deliveryInfo: DeliveryInfo(),
//   partyOutstanding: PartyOutstanding(),
//   items: [
//     SaleItem(
//       name: "strepsils",
//       precision: 2,
//       qty: 5,
//       rate: 4,
//       mrp: 5,
//       batchNo: "S1",
//       rack: "",
//       unit: "pcs",
//       taxableValue: 4.92,
//       taxRatio: 1.5,
//       cgstAmount: 0.04,
//       sgstAmount: 0.04,
//       igstAmount: 0,
//       cessAmount: 0,
//       disc: AmountInfo(amount: 0.0, mode: 'P'),
//       dAmount: 0,
//       reduction: 0,
//       salesManCode: "123",
//       salesManName: "sinc1",
//       hsnCode: "30049099",
//     ),
//     SaleItem(
//       name: "COTTON ROLL",
//       precision: 3,
//       qty: 5,
//       rate: 200,
//       mrp: 200,
//       batchNo: "CR01",
//       rack: "",
//       unit: "Kilogram",
//       taxableValue: 177.68,
//       taxRatio: 12,
//       cgstAmount: 10.66,
//       sgstAmount: 10.66,
//       igstAmount: 0,
//       cessAmount: 1,
//       disc: AmountInfo(amount: 1, mode: 'P'),
//       dAmount: 0,
//       reduction: 0,
//       salesManCode: "234",
//       salesManName: "sinc2",
//       hsnCode: "CR001",
//     ),
//   ],
//   taxSummary: [
//     TaxSummary(
//       ratio: 1.5,
//       value: 4.92,
//       sgst: 0.04,
//       cgst: 0.04,
//       igst: 0,
//       cess: 0,
//     ),
//     TaxSummary(
//       ratio: 12,
//       value: 177.68,
//       sgst: 10.66,
//       cgst: 10.66,
//       igst: 0,
//       cess: 1,
//     ),
//   ],
//   discount: 0,
//   rounded: 0.5,
//   accountAdjustment: 0,
//   shippingCharge: 0,
//   netAmount: 205,
//   patientName: "dia",
//   doctorName: "Dr.Kannan",
//   lut: true,
//   billedBy: "dia",
//   salesManName: null,
//   description: null,
//   qrCode: null,
// );

final saleData = SaleData(
  title: "Sale",
  orgName: "JN SUPER MARKET",
  branchInfo: BranchInfo(
    displayName: "DP ROAD",
    gstNo: "33AANFV6837B1Z2",
    phone: "04617485961",
    mobileNos: ["7412589630", "8523697410"],
    address: AddressInfo(
      address: "43, Toovipuram Main",
      city: "Thoothukudi",
      pincode: null,
    ),
  ),
  voucherInfo: VoucherInfo(
    voucherNo: "DP23244",
    date: "2023-09-30",
    time: "2023-09-26T08:19:25.692492600Z",
    refNo: "SL1",
    voucherName: "Sale",
    voucherType: "voucher_type:sale",
  ),
  partyInfo: PartyInfo(
    name: "Santhiyaa",
    mobileNos: [],
    address: AddressInfo(
      address: "12,Anna Nagar",
      pincode: "628003",
      state: "TN",
      country: "INDIA",
    ),
  ),
  deliveryInfo: DeliveryInfo(),
  partyOutstanding: PartyOutstanding(),
  items: [
    SaleItem(
      name: "strepsils",
      precision: 2,
      qty: 5,
      rate: 4,
      mrp: 5,
      batchNo: "S1",
      rack: "",
      unit: "pcs",
      taxableValue: 4.92,
      taxRatio: 1.5,
      cgstAmount: 0.04,
      sgstAmount: 0.04,
      igstAmount: 0,
      cessAmount: 0,
      disc: AmountInfo(amount: 0.0, mode: 'P'),
      dAmount: 0,
      reduction: 0,
      salesManCode: "123",
      salesManName: "sinc1",
      hsnCode: "30049099",
    ),
    SaleItem(
      name: "COTTON ROLL",
      precision: 3,
      qty: 5,
      rate: 200,
      mrp: 200,
      batchNo: "CR01",
      rack: "",
      unit: "Kilogram",
      taxableValue: 177.68,
      taxRatio: 12,
      cgstAmount: 10.66,
      sgstAmount: 10.66,
      igstAmount: 0,
      cessAmount: 1,
      disc: AmountInfo(amount: 1, mode: 'P'),
      dAmount: 0,
      reduction: 0,
      salesManCode: "234",
      salesManName: "sinc2",
      hsnCode: "CR001",
    ),
  ],
  taxSummary: [
    TaxSummary(
      ratio: 1.5,
      value: 4.92,
      sgst: 0.04,
      cgst: 0.04,
      igst: 0,
      cess: 0,
    ),
    TaxSummary(
      ratio: 12,
      value: 177.68,
      sgst: 10.66,
      cgst: 10.66,
      igst: 0,
      cess: 1,
    ),
  ],
  discount: 0,
  rounded: 0.5,
  accountAdjustment: 0,
  shippingCharge: 0,
  netAmount: 205,
  patientName: null,
  doctorName: null,
  lut: false,
  billedBy: "dia",
  salesManName: null,
  description: null,
  qrCode: null,
);

final saleLayoutAConfig = SaleLayoutAConfig(
  pageWidth: 78,
  margin: 3,
  showOrganizationAddress: true,
  showOrganizationPhone: true,
  title: "SALE",
  item: ColumnConfig(
    width: 1,
    label: "PARTICULARS",
  ),
  mrp: ColumnConfig(
    width: 1,
    label: "MRP",
  ),
  rate: ColumnConfig(
    width: 1,
    label: "RATE",
  ),
  qty: ColumnConfig(
    width: 1,
    label: "QTY",
  ),
  discount: ColumnConfig(
    width: 0,
    label: "DISC",
  ),
  amount: ColumnConfig(
    width: 1,
    label: "AMOUNT",
  ),
  // termsAndConditions: [
  //   "Kindly keep a Photo copy for future use",
  //   "Exchange within 7 days"
  // ],
  // greetings: "Thank you visit us again...",
);

final saleLayoutBConfig = SaleLayoutBConfig(
  pageWidth: 210,
  pageHeight: 297,
  margin: 5,
  orientation: "portrait",
  showOrganizationName: true,
  showOrganizationAddress: true,
  showOrganizationPhone: true,
  showOrganizationDetails: true,
  showPartyInfo: true,
  showVoucherInfo: true,
  serialNo: ColumnConfig(
    width: 0.5,
    label: "#",
  ),
  item: ColumnConfig(
    width: 1.5,
    label: "ITEMS",
  ),
  qty: ColumnConfig(
    width: 1,
    label: "QTY",
  ),
  mrp: ColumnConfig(
    width: 1,
    label: "MRP",
  ),
  rate: ColumnConfig(
    width: 1,
    label: "RATE",
  ),
  hsnCode: ColumnConfig(
    width: 1,
    label: "HSN",
  ),
  unit: ColumnConfig(
    width: 1,
    label: "UNIT",
  ),
  taxableValue: ColumnConfig(
    width: 1.5,
    label: "TAXABLE VALUE",
  ),
  taxAmount: ColumnConfig(
    width: 1.5,
    label: "TAX AMOUNT",
  ),
  taxRatio: ColumnConfig(
    width: 1,
    label: "TAX %",
  ),
  discount: ColumnConfig(
    width: 1,
    label: "DISC",
  ),
  amount: ColumnConfig(
    width: 1.5,
    label: "AMOUNT",
  ),
  showGSTSummary: false,
  showBillDetails: false,
  showBankDetails: BankDetails(
    enabled: false,
    bankName: "ICIC BANK LTD",
    acName: "JN SUPER MARKET",
    acNo: "613905023899",
    ifscCode: "ICIC0006139",
    panNo: "AARFJ3294N",
  ),
  showBalanceDetails: false,
  termsAndConditions: [
    "Kindly keep a Photo copy for future use",
    "Exchange within 7 days"
  ],
  greetings: null,
);

final saleLayoutA6Config = SaleLayoutA6Config(
  pageWidth: 148,
  pageHeight: 105,
  margin: 5,
  showOrganizationName: true,
  showOrganizationAddress: true,
  showOrganizationPhone: true,
  showOrganizationDetails: true,
  showContactInfo: true,
  item: ColumnConfig(
    width: 2,
    label: "PARTICULARS",
  ),
  rack: ColumnConfig(
    width: 1,
    label: "RACK",
  ),
  batchNo: ColumnConfig(
    width: 1,
    label: "BATCH",
  ),
  expiry: ColumnConfig(
    width: 1,
    label: "EXP",
  ),
  qty: ColumnConfig(
    width: 1,
    label: "QTY",
  ),
  mrp: ColumnConfig(
    width: 1,
    label: "MRP",
  ),
  rate: ColumnConfig(
    width: 1,
    label: "RATE",
  ),
  discount: ColumnConfig(
    width: 1,
    label: "DISC",
  ),
  amount: ColumnConfig(
    width: 1,
    label: "AMOUNT",
  ),
  showGSTSummary: false,
  showBillDetails: false,
);
