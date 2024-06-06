class User {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final String? token;
  final String? phoneNumber;
  final String? name;
  final String? lastName;
  final String? address;
  final String? birthDate;
  final String? gender;
  final String? image;
  final String? identification;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.role,
    this.token,
    this.phoneNumber,
    this.name,
    this.lastName,
    this.address,
    this.birthDate,
    this.gender,
    this.image,
    this.identification,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      token: json['token'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      lastName: json['lastName'],
      address: json['address'],
      birthDate: json['birthDate'],
      gender: json['sexo'],
      image: json['image'],
      identification: json['ci'],
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
      'phoneNumber': phoneNumber,
      'name': name,
      'lastName': lastName,
      'address': address,
      'birthDate': birthDate,
      'gender': gender,
      'image': image,
      'identification': identification,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, password: $password, role: $role, token: $token, phoneNumber: $phoneNumber, name: $name, lastName: $lastName, address: $address, birthDate: $birthDate, birthDate: $gender, image: $image, identification: $identification}';
  }

  //tocopy
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? role,
    String? token,
    String? phoneNumber,
    String? name,
    String? lastName,
    String? address,
    String? birthDate,
    String? gender,
    String? image,
    String? identification,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      token: token ?? this.token,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      identification: identification ?? this.identification,
    );
  }
}
