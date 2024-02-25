import 'dart:core';

class SignupModel {
  late String firstname;
  late String lastname;
  late String usertype;
  late String email;
  late String contact;
  late String password;

  SignupModel(this.firstname, this.lastname, this.usertype, this.contact,
      this.email, this.password);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'FirstName': firstname,
        'LastName': lastname,
        'UserType': usertype,
        'ContactNo': contact,
        'Email': email,
        'Password': password
      };

  factory SignupModel.fromJson(Map<String, dynamic> v) {
    return SignupModel(v["firstname"], v["lastname"], v["usertype"],
        v["contact"], v["email"], v["password"]);
  }
}
