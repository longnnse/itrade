class RegisterAccountParam {
  late String userName;
  late String password;
  late String email;
  late String firstName;
  late String lastName;
  late String address;
  late String phoneNumber;
  late String age;
  late String idenficationNumber;

  RegisterAccountParam(
      {required this.userName,
        required this.password,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.address,
        required this.phoneNumber,
        required this.age,
        required this.idenficationNumber});

  RegisterAccountParam.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    idenficationNumber = json['idenficationNumber'];
  }
}