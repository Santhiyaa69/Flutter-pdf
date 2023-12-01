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

class LayoutAHeader {
  final bool showOrganizationName;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationDetails;
  // final bool showPartyInfo;

  LayoutAHeader({
    this.showOrganizationName = false,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationDetails = false,
    // this.showPartyInfo = false,
  });
}

class TransactionConfig {
  final bool enabled;
  final double width;
  final String? label;

  TransactionConfig({
    this.enabled = false,
    required this.width,
    required this.label,
  });
}

class LayoutATransactionInfo {
  final TransactionConfig item;
  final TransactionConfig qty;
  final TransactionConfig mrp;
  final TransactionConfig rate;
  final TransactionConfig amount;
  final TransactionConfig discount;

  LayoutATransactionInfo({
    required this.item,
    required this.qty,
    required this.mrp,
    required this.rate,
    required this.amount,
    required this.discount,
  });
}

class LayoutAFooter {
  final List<String>? termsAndConditions;
  final String? greetings;

  LayoutAFooter({
    this.termsAndConditions,
    this.greetings,
  });
}

class SalePdfLayoutAConfig {
  final double pageWidth;
  final LayoutAHeader header;
  final LayoutATransactionInfo transactionInfo;
  final LayoutAFooter footer;

  SalePdfLayoutAConfig({
    required this.pageWidth,
    required this.header,
    required this.transactionInfo,
    required this.footer,
  });
}

class LayoutBHeader {
  final bool showOrganizationName;
  final bool showOrganizationAddress;
  final bool showOrganizationPhone;
  final bool showOrganizationDetails;
  final bool showPartyInfo;
  final bool showVoucherInfo;
  final bool showContactInfo; //[patient and doctor]

  LayoutBHeader({
    this.showOrganizationName = false,
    this.showOrganizationAddress = false,
    this.showOrganizationPhone = false,
    this.showOrganizationDetails = false,
    this.showPartyInfo = false,
    this.showVoucherInfo = false,
    this.showContactInfo = false,
  });
}

class LayoutBTransactionInfo {
  final TransactionConfig serialNo;
  final TransactionConfig item;
  final TransactionConfig hsnCode;
  final TransactionConfig qty;
  final TransactionConfig mrp;
  final TransactionConfig rate;
  final TransactionConfig unit;
  final TransactionConfig taxableValue;
  final TransactionConfig taxRatio;
  final TransactionConfig taxAmount;
  final TransactionConfig discount;
  final TransactionConfig amount;

  LayoutBTransactionInfo({
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

class LayoutBFooter {
  final bool showGSTSummary;
  final BankDetails? showBankDetails;
  final bool showBillDetails;
  final bool showBalanceDetails;
  final List<String>? termsAndConditions;
  final String? greetings;

  LayoutBFooter({
    this.showGSTSummary = false,
    this.showBankDetails,
    this.showBillDetails = false,
    this.showBalanceDetails = false,
    this.termsAndConditions,
    this.greetings,
  });
}

class SalePdfLayoutBConfig {
  final double pageWidth;
  final double pageHeight;
  final LayoutBHeader header;
  final LayoutBTransactionInfo transactionInfo;
  final LayoutBFooter footer;

  SalePdfLayoutBConfig({
    required this.pageWidth,
    required this.pageHeight,
    required this.header,
    required this.transactionInfo,
    required this.footer,
  });
}

final saleData = SaleData(
  title: "Sale",
  orgName: "MA MEDICALS",
  branchInfo: BranchInfo(
    displayName: "DP ROAD",
    gstNo: "33ANEPA4609G3ZI",
    licNo: "",
    phone: null,
    email: null,
    mobileNos: ["8575757546"],
    address: AddressInfo(
      address:
          "2/790,South Facing Ground Floor,Thiruvallur High Road,Gandhi Nagar",
      city: "Chennai",
      pincode: "600052",
    ),
  ),
  voucherInfo: VoucherInfo(
    voucherNo: "BAS23241",
    date: "2023-09-30",
    time: "2023-09-26T08:19:25.692492600Z",
    refNo: null,
    voucherName: "Sale",
    voucherType: "voucher_type:sale",
  ),
  partyInfo: PartyInfo(
    name: "VELAVAN HYPER MARKET PVT LTD",
    mobileNos: ["9566700835"],
    gstNo: "33AAHCV6142J1Z7",
    address: AddressInfo(
      address: "51 GIN FACTORY ROAD THOOTHUKUDI",
      pincode: "628002",
      state: "TAMILNADU",
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

final saleLayoutAConfig = SalePdfLayoutAConfig(
  pageWidth: 78,
  header: LayoutAHeader(
    showOrganizationName: true,
    showOrganizationAddress: true,
    showOrganizationPhone: true,
    showOrganizationDetails: true,
    // showPartyInfo: false,
  ),
  transactionInfo: LayoutATransactionInfo(
    item: TransactionConfig(
      enabled: true,
      width: 1,
      label: "PARTICULARS",
    ),
    mrp: TransactionConfig(
      enabled: true,
      width: 1,
      label: "MRP",
    ),
    rate: TransactionConfig(
      enabled: true,
      width: 1,
      label: "RATE",
    ),
    qty: TransactionConfig(
      enabled: true,
      width: 1,
      label: "QTY",
    ),
    discount: TransactionConfig(
      enabled: false,
      width: 1,
      label: "DISC",
    ),
    amount: TransactionConfig(
      enabled: true,
      width: 2,
      label: "AMOUNT",
    ),
  ),
  footer: LayoutAFooter(
    termsAndConditions: [
      "Kindly keep a Photo copy for future use",
      "Exchange within 7 days"
    ],
    greetings: "Thank you visit us again...",
  ),
);

final saleLayoutBConfig = SalePdfLayoutBConfig(
  pageWidth: 148,
  pageHeight: 105,
  header: LayoutBHeader(
    showOrganizationName: true,
    showOrganizationAddress: true,
    showOrganizationPhone: true,
    showOrganizationDetails: true,
    showPartyInfo: true,
    showVoucherInfo: true,
  ),
  transactionInfo: LayoutBTransactionInfo(
    serialNo: TransactionConfig(
      enabled: true,
      width: 0.5,
      label: "#",
    ),
    item: TransactionConfig(
      enabled: true,
      width: 1.5,
      label: "PARTICULARS",
    ),
    qty: TransactionConfig(
      enabled: true,
      width: 1,
      label: "QTY",
    ),
    mrp: TransactionConfig(
      enabled: true,
      width: 1,
      label: "MRP",
    ),
    rate: TransactionConfig(
      enabled: true,
      width: 1,
      label: "RATE",
    ),
    hsnCode: TransactionConfig(
      enabled: false,
      width: 1,
      label: "HSN",
    ),
    unit: TransactionConfig(
      enabled: false,
      width: 1,
      label: "UNIT",
    ),
    taxableValue: TransactionConfig(
      enabled: false,
      width: 1.5,
      label: "TAXABLE VALUE",
    ),
    taxAmount: TransactionConfig(
      enabled: false,
      width: 1.5,
      label: "TAX AMOUNT",
    ),
    taxRatio: TransactionConfig(
      enabled: true,
      width: 1,
      label: "TAX %",
    ),
    discount: TransactionConfig(
      enabled: false,
      width: 1,
      label: "DISC",
    ),
    amount: TransactionConfig(
      enabled: true,
      width: 1.5,
      label: "AMOUNT",
    ),
  ),
  footer: LayoutBFooter(
    showGSTSummary: true,
    showBankDetails: BankDetails(
      enabled: true,
      bankName: "ICIC BANK LTD",
      acName: "JN SUPER MARKET",
      acNo: "613905023899",
      ifscCode: "ICIC0006139",
      panNo: "AARFJ3294N",
    ),
    showBillDetails: false,
    showBalanceDetails: true,
    termsAndConditions: [
      // "Kindly keep a Photo copy for future use",
      // "Exchange within 7 days"
    ],
    greetings: null,
  ),
);
