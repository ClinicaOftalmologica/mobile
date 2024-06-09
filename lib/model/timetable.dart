class Timetable {
  final String? id;
  final String? Date;
  final String? Time;

  Timetable({
    this.id,
    this.Date,
    this.Time,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      id: json['id'],
      Date: json['date'],
      Time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Date': Date,
      'Time': Time,
    };
  }

  Timetable copyWith({
    String? id,
    String? Date,
    String? Time,
  }) {
    return Timetable(
      id: id ?? this.id,
      Date: Date ?? this.Date,
      Time: Time ?? this.Time,
    );
  }

  @override
  String toString() {
    return 'Timetable{id: $id, Date: $Date, Time: $Time}';
  }
}
