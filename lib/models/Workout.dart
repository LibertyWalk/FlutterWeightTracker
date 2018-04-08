import 'package:meta/meta.dart';

class Workout {
  String title;
  String id;

  Workout({
    @required this.title,
    @required this.id,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    return map;
  }

  Workout.fromDb(Map map)
      : title = map["title"],
        id = map["id"].toString();
}