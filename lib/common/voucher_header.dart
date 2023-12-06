import 'package:pdf/widgets.dart';

import 'branch_info.dart';

Widget buildVoucherHeader({
  required Context context,
  required String orgName,
  required BranchInfo branchInfo,
  bool showOrganizationAddress = true,
  bool showOrganizationPhone = true,
  bool showOrganizationMobile = true,
  bool showOrganizationEmail = true,
  bool showGstNo = true,
  bool showLicNo = true,
  String? title,
  CrossAxisAlignment? crossAxis,
}) {
  return Center(
    child: Column(
      crossAxisAlignment: crossAxis ?? CrossAxisAlignment.center,
      children: [
        Text(orgName, style: Theme.of(context).header0),
        if (showOrganizationAddress) ...[
          if (branchInfo.address.address != null)
            Text(
              branchInfo.address.address!,
              style: Theme.of(context).header1,
            ),
          if (branchInfo.address.city != null)
            Text(
              '${branchInfo.address.city!} - ${branchInfo.address.pincode ?? 1}',
              style: Theme.of(context).header1,
            ),
        ],
        if (showOrganizationPhone)
          if (branchInfo.phone != null)
            Text(
              "Phone: ${branchInfo.phone}",
              style: Theme.of(context).header1,
            ),
        if (showOrganizationMobile)
          if (branchInfo.mobileNos != null)
            Text(
              "Mobile: ${branchInfo.mobileNos?.join(",").toString()}",
              style: Theme.of(context).header1,
            ),
        if (showOrganizationEmail)
          if (branchInfo.email != null)
            Text(
              "Email: ${branchInfo.email}",
              style: Theme.of(context).header1,
            ),
        if (showGstNo)
          Text(
            "GSTIN: ${branchInfo.gstNo}",
            style: Theme.of(context).header1,
          ),
        if (showLicNo)
          if (branchInfo.licNo != null)
            Text(
              "LIC.NO: ${branchInfo.licNo}",
              style: Theme.of(context).header1,
            ),
        if (title != null)
          Text(
            title,
            style: Theme.of(context).header1,
          ),
      ],
    ),
  );
}
