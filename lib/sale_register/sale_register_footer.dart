import 'package:pdf/widgets.dart' as pw;

import '../common/filter_row.dart';
import '../common/table_cell.dart';
import 'sale_register_input.dart';

pw.Widget buildSaleRegisterFooter(double total) {
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

pw.Widget buildSaleRegDetailModeFooter(SaleRegisterSummary summary) {
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
      pw.TableRow(
        children: [
          pw.Column(
            children: [
              buildFilterRow(
                key: "EFT Amount",
                value: "Rs.${summary.eftAmount.toStringAsFixed(2)}",
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
