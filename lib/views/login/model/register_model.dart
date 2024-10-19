class UserRegister {
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String gender = "";
  DateTime birthdate = DateTime.now();


  UserRegister({
  required this.name, 
  required this.email,
  required this.password,
  required this.confirmPassword,
  required this.gender,
  required this.birthdate});
}


class UserLogin {
  String email = "";
  String password = "";
  String name = "";

  UserLogin({
    required this.email,
    required this.password,
    required this.name  
  });  
}

class DataUser {
  String name = "";
  String email = "";
  String gender = "";

  DataUser({
    required this.name,
    required this.email,
    required this.gender
  });
}