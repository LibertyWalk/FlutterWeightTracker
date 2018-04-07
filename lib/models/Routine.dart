import 'package:meta/meta.dart';

class Routine {
  String title;
  String description;
  String id;
  String workout;
  bool isExpanded;

  Routine({
    @required this.title,
    @required this.id,
    @required this.workout,
    this.description,
    this.isExpanded
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['workout'] = workout;
    return map;
  }

  Routine.fromDb(Map map)
      : title = map["title"],
        id = map["id"],
        workout = map["workout"],
        description = map["description"].toString();
}