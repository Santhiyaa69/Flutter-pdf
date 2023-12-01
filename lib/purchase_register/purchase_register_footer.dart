import 'package:pdf/widgets.dart' as pw;
import 'package:print_pdf/purchase_register/purchase_register_input.dart';

import '../common/filter_row.dart';
import '../common/table_cell.dart';

pw.Widget buildPurchaseRegisterFooter(double total) {
  return pw.Table(
    children: [
      pw.TableRow(
        children: [
          buildTableCell(
            isHeader: true,
            value: 'Total Amount : Rs.${total.toStringAsFixed(2)}',
            alignment: pw.Alignment.centerRight,
          ),
        ],
      ),
    ],
  );
}

pw.Widget buildPurchaseRegDetailModeFooter(
  PurchaseRegisterSummary summary,
) {
  return pw.Table(
    columnWidths: {
      0: const pw.FixedColumnWidth(3),
      1: const pw.FixedColumnWidth(2),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Column(
            children: [
              buildFilterRow(
                key: "Bank Amount",
                value: "Rs.${summary.bankAmount.toStringAsFixed(2)}",
              ),
            ],
          ),
          pw.Column(
            children: [
              buildFilterRow(
                key: "Total Amount",
                value: "Rs.${summary.billAmount.toStringAsFixed(2)}",
              ),
            ],
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Column(
            children: [
              buildFilterRow(
                key: "Cash Amount",
                value: "Rs.${summary.cashAmount.toStringAsFixed(2)}",
              ),
            ],
          ),
          pw.Column(
            children: [
              buildFilterRow(
                key: "Credit Amount",
                value: "Rs.${summary.creditAmount.toStringAsFixed(2)}",
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
