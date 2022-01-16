class UserData {
  final String name;
  final String username;
  final String email;
  final String gender;

  UserData(
      {required this.name,
      required this.username,
      required this.email,
      required this.gender});

  UserData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        username = json['username'],
        email = json['email'],
        gender = json['gender'];
}
