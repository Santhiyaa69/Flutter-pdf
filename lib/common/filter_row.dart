import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget buildFilterRow({
  required String key,
  required String value,
  double? keyWidth,
  PdfColor? textColor,
  pw.MainAxisAlignment? mainAxisalignment,
}) {
  return pw.Row(
    mainAxisAlignment: mainAxisalignment ?? pw.MainAxisAlignment.start,
    children: [
      pw.SizedBox(
        child: pw.Text(
          key,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        width: keyWidth ?? 100,
      ),
      pw.SizedBox(
        child: pw.Text(
          ":",
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        width: 15,
      ),
      pw.SizedBox(
        child: pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    ],
  );
}
