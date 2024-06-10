import 'package:medilab_prokit/model/doctor.dart';

class Medication {
  final String? id;
  final String detail;
  final String title;
  final String recipe;
  final Doctor doctor;

  Medication({
    this.id,
    required this.detail,
    required this.title,
    required this.recipe,
    required this.doctor,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      detail: json['detail'],
      title: json['title'],
      recipe: json['recipe'],
      doctor: Doctor.fromJson(json['doctor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'detail': detail,
      'title': title,
      'recipe': recipe,
      'doctor': doctor.toJson(),
    };
  }

  Medication copyWith({
    String? id,
    String? detail,
    String? title,
    String? recipe,
    Doctor? doctor,
  }) {
    return Medication(
      id: id ?? this.id,
      detail: detail ?? this.detail,
      title: title ?? this.title,
      recipe: recipe ?? this.recipe,
      doctor: doctor ?? this.doctor,
    );
  }

  @override
  String toString() {
    return 'Medication{id: $id, detail: $detail, title: $title, recipe: $recipe, doctor: $doctor}';
  }
}