import 'package:medilab_prokit/model/doctor.dart';

class Timetable {
  final String? id;
  final String? Date;
  final String? Time;
  final Doctor? doctor;

  Timetable({
    this.id,
    this.Date,
    this.Time,
    this.doctor,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      id: json['id'],
      Date: json['date'],
      Time: json['time'],
      doctor: Doctor.fromJson(json['doctor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Date': Date,
      'Time': Time,
      'doctor': doctor?.toJson(),
    };
  }

  Timetable copyWith({
    String? id,
    String? Date,
    String? Time,
    Doctor? doctor,
  }) {
    return Timetable(
      id: id ?? this.id,
      Date: Date ?? this.Date,
      Time: Time ?? this.Time,
      doctor: doctor ?? this.doctor,
    );
  }

  @override
  String toString() {
    return 'Timetable{id: $id, Date: $Date, Time: $Time, doctor: $doctor}';
  }
}
