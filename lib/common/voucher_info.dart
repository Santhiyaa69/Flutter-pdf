class VoucherInfo {
  final String voucherNo;
  final String date;
  final String time;
  final String? refNo;
  final String voucherName;
  final String voucherType;

  VoucherInfo({
    required this.voucherNo,
    required this.date,
    required this.time,
    this.refNo,
    required this.voucherName,
    required this.voucherType,
  });
}
