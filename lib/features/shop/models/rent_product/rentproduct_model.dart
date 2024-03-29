import 'dart:core';

class RentProductModel {
  late String key;
  late String catid;
  late String rname;
  late String rphoto1;
  late String rphoto2;
  late String rphoto3;
  late String rprice;
  late String rsize;
  late int rqty;
  late String rcolour;
  late String rfabric;
  late String rdetails;
  late String ravailability;
  late String rdatetime;

  RentProductModel(
      this.key,
      this.catid,
      this.rname,
      this.rphoto1,
      this.rphoto2,
      this.rphoto3,
      this.rprice,
      this.rsize,
      this.rqty,
      this.rcolour,
      this.rfabric,
      this.rdetails,
      this.rdatetime,
      this.ravailability);

  factory RentProductModel.fromJson(Map<String, dynamic> document) {
    return RentProductModel(
        document["key"],
        document["catid"],
        document["rname"],
        document["rphoto1"],
        document["rphoto2"],
        document["rphoto3"],
        document["rprice"],
        document["rsize"],
        document["rqty"],
        document["rcolour"],
        document["rfabric"],
        document["rdetails"],
        document["rdatetime"],
        document["ravailability"]);
  }
}
