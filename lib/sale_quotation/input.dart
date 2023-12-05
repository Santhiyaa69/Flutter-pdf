import '../common/amount_info.dart';
import '../common/branch_info.dart';
import '../common/tax_summary.dart';
import '../common/voucher_info.dart';
import '../main.dart';
import '../sale/input.dart';

class SaleQuotationItem {
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

  SaleQuotationItem({
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
  });
}

class SaleQuotationData {
  final String title;
  final String orgName;
  final BranchInfo branchInfo;
  final VoucherInfo voucherInfo;
  final PartyInfo partyInfo;
  final bool lut;
  final String billedBy;
  final String? description;
  final List<SaleQuotationItem> items;
  final List<TaxSummary> taxSummary;
  final String? salesManName;
  final double discount;
  final double rounded;
  final double accountAdjustment;
  final double shippingCharge;
  final double netAmount;

  SaleQuotationData({
    required this.title,
    required this.orgName,
    required this.branchInfo,
    required this.voucherInfo,
    required this.partyInfo,
    required this.items,
    required this.taxSummary,
    this.salesManName,
    required this.discount,
    required this.rounded,
    required this.accountAdjustment,
    required this.shippingCharge,
    required this.netAmount,
    required this.lut,
    required this.billedBy,
    this.description,
  });
}

class SaleQuotationConfig {
  final double pageWidth;
  final double pageHeight;
  final double margin;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationMobile;
  final bool showOrganizationEmail;
  final bool showGstNo;
  final bool showLicNo;
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
  final List<String>? termsAndConditions;
  final String? greetings;

  SaleQuotationConfig({
    required this.pageWidth,
    required this.pageHeight,
    required this.margin,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationMobile = false,
    this.showOrganizationEmail = false,
    this.showGstNo = false,
    this.showLicNo = false,
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
    this.termsAndConditions,
    this.greetings,
  });
}

final saleQuotationData = SaleQuotationData(
  title: "Sale",
  orgName: "VELAVAN HYPERMARKET BOOKS & STATIONERY",
  branchInfo: BranchInfo(
    displayName: "DP ROAD",
    gstNo: "33AIVPV0468N1ZC",
    phone: "04612383801",
    mobileNos: ["9842019102", "7373776102"],
    address: AddressInfo(
      address: "2nd FLOOR,45,GIN FACTORY ROAD",
      city: "TUTICORIN",
      pincode: "628002",
    ),
  ),
  voucherInfo: VoucherInfo(
    voucherNo: "MBBB23242758",
    date: "2023-11-21",
    time: "06.07 P.M",
    refNo: null,
    voucherName: "Sale Quotation",
    voucherType: "voucher_type:sale_quotaion",
  ),
  partyInfo: PartyInfo(
    name: "PHILIPS FOOD INDIA PVT.LTD.",
    mobileNos: ["9944003179"],
    gstNo: "33AABCP7916Q2ZW",
    address: AddressInfo(
      address:
          "PLOT NO.C-75/76, SIPCOT INDUSTRIAL COMPLEX,MADATHOOR P.O.,TUTICORIN",
      pincode: "628008",
      state: "TAMILNADU",
      country: "INDIA",
    ),
  ),
  items: [
    SaleQuotationItem(
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
      hsnCode: "30049099",
    ),
    SaleQuotationItem(
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
  lut: true,
  billedBy: "dia",
  salesManName: null,
  description: null,
);

final saleQuotationConfig = SaleQuotationConfig(
  pageWidth: 210,
  pageHeight: 297,
  margin: 5,
  showOrganizationAddress: true,
  showOrganizationPhone: true,
  showPartyInfo: true,
  showVoucherInfo: true,
  serialNo: ColumnConfig(
    width: 0.5,
    label: "#",
  ),
  item: ColumnConfig(
    width: 1.5,
    label: "PARTICULARS",
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
    width: 0,
    label: "HSN",
  ),
  unit: ColumnConfig(
    width: 0,
    label: "UNIT",
  ),
  taxableValue: ColumnConfig(
    width: 0,
    label: "TAXABLE VALUE",
  ),
  taxAmount: ColumnConfig(
    width: 0,
    label: "TAX AMOUNT",
  ),
  taxRatio: ColumnConfig(
    width: 1,
    label: "TAX %",
  ),
  discount: ColumnConfig(
    width: 1,
    label: "DIS.%",
  ),
  amount: ColumnConfig(
    width: 1.5,
    label: "AMOUNT",
  ),
  showGSTSummary: true,
  showBillDetails: false,
  showBankDetails: BankDetails(
    enabled: true,
    bankName: "HDFC BANK LTD",
    acName: "VELAVAN HYPERMARKET BOOKS & STATIONERY",
    acNo: "50200071241571",
    ifscCode: "HDFC0001104",
    panNo: "AIVPV0468N",
  ),
  termsAndConditions: ["This Quotation is valid only for 15 days from issued"],
  greetings: "Thank you visit us Again",
);
