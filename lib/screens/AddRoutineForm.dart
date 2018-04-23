import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Routine.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/database/AppDatabase.dart';
import 'package:uuid/uuid.dart';

class AddRoutineForm extends StatefulWidget {
  final Workout workout;
  AddRoutineForm(this.workout);
  @override
  AddRoutineFormState createState() => new AddRoutineFormState();
}

class AddRoutineFormState extends State<AddRoutineForm> {
  Workout workoutState;
  String routineTitle;
  String routineNotes;
  static var uuid = new Uuid();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    workoutState = widget.workout;
    print("Opening Screen: " + workoutState.title);
  }

  void navigateBack() {
    Routine routine = new Routine(
        title: routineTitle,
        notes: routineNotes,
        id: uuid.v4(),
        isExpanded: false,
        workout: workoutState.title);
    AppDatabase db = new AppDatabase();
    db.addRoutine(routine);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add a new workout"),
        ),
        body: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter title"
                ),
                validator: (title) {
                  if (title.isEmpty) {
                    return 'Please enter a title';
                  } else {
                    routineTitle = title;
                  }
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter notes"
                ),
                autofocus: true,
                validator: (notes) {
                  
                },
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      navigateBack();
                    }
                  },
                  child: new Text('Save'),
                ),
              ),
            ],
          ),
        ));
  }
}
