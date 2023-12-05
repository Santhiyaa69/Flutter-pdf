import '../main.dart';

partyInfoAddr1(PartyInfo data) {
  if (data.address?.city != null && data.address?.pincode != null) {
    return '${data.address!.city!}-${data.address!.pincode!}';
  } else if (data.address?.city != null) {
    return data.address!.city!;
  } else if (data.address?.pincode != null) {
    return data.address!.pincode!;
  }
}

partyInfoAddr2(PartyInfo data) {
  if (data.address?.state != null && data.address?.country != null) {
    return '${data.address!.state!},${data.address!.country!}';
  } else if (data.address?.state != null) {
    return data.address!.state!;
  } else if (data.address?.country != null) {
    return data.address!.country!;
  }
}
