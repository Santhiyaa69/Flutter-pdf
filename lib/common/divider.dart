import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget buildDivider({double? height}) {
  return Divider(
    height: height ?? 0,
    color: PdfColors.grey800,
  );
}
