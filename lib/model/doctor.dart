import 'package:medilab_prokit/model/user.dart';

class Doctor {
  final String? id;
  final String? name;
  final String? lastName;
  final String? address;
  final String? identification;
  final String? gender;
  final String? phoneNumber;
  final String? title;
  final User? user;

  Doctor({
    this.id,
    this.name,
    this.lastName,
    this.address,
    this.identification,
    this.gender,
    this.phoneNumber,
    this.title,
    this.user,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      address: json['address'] ?? '',
      identification: json['ci'] ?? '',
      gender: json['sexo'] ?? '',
      phoneNumber: json['contactNumber'] ?? '',
      title: json['titulo'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'address': address,
      'ci': identification,
      'sexo': gender,
      'contactNumber': phoneNumber,
      'titulo': title,
      'user': user?.toJson(),
    };
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? lastName,
    String? address,
    String? identification,
    String? gender,
    String? phoneNumber,
    String? title,
    User? user,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      identification: identification ?? this.identification,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      title: title ?? this.title,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'Doctor{id: $id, name: $name, lastName: $lastName, address: $address, identification: $identification, gender: $gender, phoneNumber: $phoneNumber, title: $title, user: $user}';
  }
}
