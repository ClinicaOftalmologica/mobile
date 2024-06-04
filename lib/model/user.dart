class User {
  final String? id;
  final String username;
  final String? email;
  final String? password;
  final String? role;
  final String? token;

  User({
    this.id,
    required this.username,
    this.email,
    this.password,
    this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, password: $password, role: $role, token: $token}';
  }

  //tocopy
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
