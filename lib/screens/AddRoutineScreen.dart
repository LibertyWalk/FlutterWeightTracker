import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Routine.dart';
import 'package:weight_tracker/database/AppDatabase.dart';
import 'package:uuid/uuid.dart';

class AddWorkoutScreen extends StatefulWidget {
  @override
  AddWorkoutScreenState createState() => new AddWorkoutScreenState();
}

class AddWorkoutScreenState extends State<AddWorkoutScreen> {


  static var uuid = new Uuid();
  Routine routine =
      new Routine(title: "", description: "", id: uuid.v4(), isExpanded: false, workout: "");


  void navigateBack() {
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
              onChanged: (String input) => routine.title = input,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Description",
              ),
              onChanged: (String input) => routine.description = input,
            ),
          ),
        ],
      ),
    );
  }
}
