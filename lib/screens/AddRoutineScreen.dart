import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Routine.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/database/AppDatabase.dart';
import 'package:uuid/uuid.dart';

class AddRoutineScreen extends StatefulWidget {
  //final Workout workout;
  final String workoutTitle;
  AddRoutineScreen(this.workoutTitle);
  @override
  AddRoutineScreenState createState() => new AddRoutineScreenState();
}

class AddRoutineScreenState extends State<AddRoutineScreen> {

  String workoutTitleString;
  static String proxyString;
  String routineTitle;
  String routineNotes;
  static var uuid = new Uuid();

  @override
  void initState() {
    super.initState();
    workoutTitleString = widget.workoutTitle;
    proxyString = workoutTitleString;
    print("Opening Screen: " + proxyString);
  }



  void navigateBack() {
    Routine routine =
      new Routine(title: routineTitle, notes: routineNotes, id: uuid.v4(), isExpanded: false, workout: proxyString);
    AppDatabase db = new AppDatabase();
    db.addRoutine(routine);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add a new workout"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.save),
            onPressed: () => navigateBack(),
          )
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Title",
              ),
              onChanged: (String input) => routineTitle = input,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "notes",
              ),
              onChanged: (String input) => routineNotes = input,
            ),
          ),
        ],
      ),
    );
  }
}
