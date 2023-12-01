import 'package:pdf/widgets.dart' as pw;

pw.Widget buildTableCell({
  bool isHeader = false,
  String? value,
  pw.Alignment? alignment,
  pw.TextStyle? textStyle,
  double? width,
  pw.Widget? widget,
}) {
  return pw.Container(
    padding: isHeader
        ? const pw.EdgeInsets.symmetric(
            horizontal: 2,
          )
        : const pw.EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 2,
          ),
    alignment: alignment,
    width: width,
    child: widget ??
        pw.Text(
          value ?? '',
          style: isHeader
              ? textStyle ??
                  pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  )
              : textStyle ??
                  const pw.TextStyle(
                    fontSize: 11,
                  ),
        ),
  );
}
