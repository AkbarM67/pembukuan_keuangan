class UserModel {
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
  });

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  // Create object from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
