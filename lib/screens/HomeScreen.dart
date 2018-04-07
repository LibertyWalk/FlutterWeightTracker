import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/database/AppDatabase.dart';
import 'package:weight_tracker/screens/AddWorkoutScreen.dart';
import 'package:weight_tracker/widgets/WorkoutItem.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Workout> workouts = new List();

  @override
  void initState() {
    super.initState();
    populateWorkouts();
  }

  void openAddWorkoutScreen() async {
    Navigator
        .push(context,
            new MaterialPageRoute(builder: (context) => new AddWorkoutScreen()))
        .then((b) {
      populateWorkouts();
    });
  }

  void populateWorkouts() async {
    AppDatabase db = new AppDatabase();
    db.getAllWorkouts().then((newWorkouts) {
      setState(() => workouts = newWorkouts);
    });
  }

  String keyGen() {
    Uuid uuid = new Uuid();
    return uuid.v4().toString();
  }

  void clearDb() async {
    AppDatabase db = new AppDatabase();
    db.clearWorkouts();
    populateWorkouts();
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
                itemCount: workouts.length,
                itemBuilder: (BuildContext context, int index) {
                  return new WorkoutItem(workouts[index], onDelete: (id) {
                    AppDatabase db = new AppDatabase();
                    db.deleteWorkout(id).then((b) {
                      populateWorkouts();
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
