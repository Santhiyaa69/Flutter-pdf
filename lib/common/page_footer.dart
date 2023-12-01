import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget buildPageFooter(Context context) {
  return pw.Container(
    height: 0,
    alignment: pw.Alignment.centerRight,
    child: pw.Text(
      "Page ${context.pageNumber}/${context.pagesCount}",
      // style: const pw.TextStyle(fontSize: 10),
    ),
  );
}
