import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Routine.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/database/AppDatabase.dart';
import 'package:weight_tracker/screens/AddWorkoutScreen.dart';
import 'package:weight_tracker/widgets/RoutineItem.dart';
import 'package:uuid/uuid.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final Workout workout;
  WorkoutDetailScreen(this.workout);
  @override
  WorkoutDetailScreenState createState() => new WorkoutDetailScreenState();
}

class WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<Routine> routines = new List();
  Workout workoutState;
  @override
  void initState() {
    super.initState();
    populateRoutines();
    workoutState = widget.workout;
  }

  void openAddWorkoutScreen() async {
    Navigator
        .push(context,
            new MaterialPageRoute(builder: (context) => new AddWorkoutScreen()))
        .then((b) {
      populateRoutines();
    });
  }

  void populateRoutines() async {
    AppDatabase db = new AppDatabase();
    db.getAllRoutines(workoutState.title).then((newRoutines) {
      setState(() => routines = newRoutines);
    });
  }

  String keyGen() {
    Uuid uuid = new Uuid();
    return uuid.v4().toString();
  }

  void clearDb() async {
    AppDatabase db = new AppDatabase();
    db.clearWorkouts();
    populateRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weight Tracker"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.delete),
            onPressed: () => clearDb(),
          )
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(
                key: new Key(keyGen()),
                padding: new EdgeInsets.all(10.0),
                itemCount: routines.length,
                itemBuilder: (BuildContext context, int index) {
                  return new RoutineItem(routines[index], onDelete: (id) {
                    AppDatabase db = new AppDatabase();
                    db.deleteWorkout(id).then((b) {
                      populateRoutines();
                    });
                  });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add), onPressed: () => openAddWorkoutScreen()),
    );
  }
}