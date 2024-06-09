import 'package:medilab_prokit/model/timetable.dart';

class Reservation {
  final String? id;
  final String? place;
  final String state;
  final Timetable? timetable;

  Reservation({
    this.id,
    this.place,
    required this.state,
    this.timetable,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      place: json['place'],
      state: json['state'],
      timetable: Timetable.fromJson(json['available_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place': place,
      'state': state,
      'timetable': timetable?.toJson(),
    };
  }

  Reservation copyWith({
    String? id,
    String? place,
    String? state,
    Timetable? timetable,
  }) {
    return Reservation(
      id: id ?? this.id,
      place: place ?? this.place,
      state: state ?? this.state,
      timetable: timetable ?? this.timetable,
    );
  }

  @override
  String toString() {
    return 'Reservation{id: $id, place: $place, state: $state, timetable: $timetable}';
  }
}
