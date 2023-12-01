import 'package:pdf/widgets.dart' as pw;

import '../main.dart';

pw.Widget buildReportHeader({
  required String orgName,
  required BranchInfo branchInfo,
  required String title,
  String? fromDate,
  String? toDate,
  String? asOnDate,
}) {
  final date = asOnDate ?? toDate;
  return pw.Center(
    child: pw.Column(
      children: [
        pw.Text(
          orgName,
          style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold),
        ),
        if (branchInfo.address.address != null)
          pw.Text(
            branchInfo.address.address!,
            style: const pw.TextStyle(fontSize: 12),
          ),
        if (branchInfo.address.city != null)
          pw.Text(
            '${branchInfo.address.city!} - ${branchInfo.address.pincode ?? 1}',
            style: const pw.TextStyle(fontSize: 12),
          ),
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
        ),
        if (fromDate != null || asOnDate != null || toDate != null)
          pw.Text(
            (fromDate != null) ? '$fromDate to $toDate' : 'As On Date : $date',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
      ],
    ),
  );
}
