class EditPasswordParam {
  late String email;
  late String currentPassword;
  late String newPassword;

  EditPasswordParam(
      {required this.email,
        required this.currentPassword,
        required this.newPassword});

  EditPasswordParam.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }
}