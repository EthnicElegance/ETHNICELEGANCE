import 'dart:core';

class AddressViewModel {
  late String addressId;
  late String userid;
  late String name;
  late String contact;
  late String address;
  late String pincode;
  late String city;
  late String state;

  AddressViewModel(this.addressId,this.userid,this.name, this.contact, this.address, this.pincode,
      this.city, this.state);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'AddressId':addressId,
    'UserId':userid,
    'Name': name,
    'Contact': contact,
    'Address': address,
    'Pincode': pincode,
    'City': city,
    'State': state
  };

  factory AddressViewModel.fromJson(Map<String, dynamic> v) {
    return AddressViewModel(v["AddressId"],v["UserId"],v["Name"], v["Contact"], v["Address"],
        v["Pincode"], v["City"], v["State"]);
  }
}
