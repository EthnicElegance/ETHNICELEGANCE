import 'dart:core';

class AddressModel {
  late String userid;
  late String name;
  late String contact;
  late String address;
  late String pincode;
  late String city;
  late String state;

  AddressModel(this.userid,this.name, this.contact, this.address, this.pincode,
      this.city, this.state);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{

    'UserId':userid,
    'Name': name,
    'Contact': contact,
    'Address': address,
    'Pincode': pincode,
    'City': city,
    'State': state
  };

  factory AddressModel.fromJson(Map<String, dynamic> v) {
    return AddressModel(v["UserId"],v["Name"], v["Contact"], v["Address"],
        v["Pincode"], v["City"], v["State"]);
  }
}
