import 'package:meta/meta.dart';

class Routine {
  String title;
  String notes;
  String id;
  String workout;
  double weight;
  double reps;
  bool isExpanded;

  Routine({
    @required this.title,
    @required this.id,
    @required this.workout,
    this.notes,
    this.isExpanded,
    this.weight,
    this.reps
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['notes'] = notes;
    map['workout'] = workout;
    map['weight'] = weight;
    map['reps'] = reps;
    return map;
  }

  Routine.fromDb(Map map)
      : title = map["title"],
        id = map["id"],
        workout = map["workout"],
        notes = map["notes"].toString(),
        weight = map["weight"],
        reps = map["reps"];
}