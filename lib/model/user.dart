class User {
  final String? id;
  final String? username;
  final String? email;
  final String? role;
  final String? token;
  final bool isLogged = false;

  User({
    this.id,
    this.username,
    this.email,
    this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, role: $role, token: $token, isLogged: $isLogged}';
  }

  //tocopy
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
