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
