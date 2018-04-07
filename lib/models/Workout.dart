import 'package:meta/meta.dart';

class Workout {
  String title;
  String description;
  String id;
  bool isExpanded;

  Workout({
    @required this.title,
    @required this.id,
    this.description,
    this.isExpanded
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    return map;
  }

  Workout.fromDb(Map map)
      : title = map["title"],
        id = map["id"],
        description = map["description"].toString();
}