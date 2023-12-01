class AddressInfo {
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;

  AddressInfo({
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
  });
}

class BranchInfo {
  final String displayName;
  final String gstNo;
  final String? licNo;
  final String? phone;
  final AddressInfo address;
  final List<String>? mobileNos;
  final String? email;

  BranchInfo({
    required this.displayName,
    required this.gstNo,
    this.licNo,
    this.phone,
    required this.address,
    this.mobileNos,
    this.email,
  });
}
