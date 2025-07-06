class User {
  int? id;
  String name;
  String email;

  User({this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'], // JSONPlaceholder uses 'name' directly
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
  };
}

