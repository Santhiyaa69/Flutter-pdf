import 'package:pdf/widgets.dart';

Widget buildPageHeader(String voucherName) {
  return Container(
    padding: const EdgeInsets.only(top: -15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("ORIGINAL COPY"),
        Text("TAX INVOICE"),
        Text(voucherName),
      ],
    ),
  );
}
