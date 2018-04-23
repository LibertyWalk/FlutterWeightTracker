import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/database/AppDatabase.dart';
import 'package:weight_tracker/screens/WorkoutDetailScreen.dart';

class WorkoutItem extends StatefulWidget {
  final Workout workout;
  final Function onDelete;

  WorkoutItem(this.workout, {this.onDelete});

  @override
  WorkoutItemState createState() => new WorkoutItemState();
}

class WorkoutItemState extends State<WorkoutItem> {
  Workout workoutState;
  AppDatabase db = new AppDatabase();

  @override
  void initState() {
    super.initState();
    workoutState = widget.workout;
  }

  void openWorkoutDetailScreen() async {
    Navigator
        .push(context,
            new MaterialPageRoute(builder: (context) => new WorkoutDetailScreen(workoutState)));
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            onTap:() => openWorkoutDetailScreen(),
            leading: const Icon(Icons.check), //Maybe image?
            title: new RichText(
              text: new TextSpan(
                  text: workoutState.title,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w200,
                      color: Colors.black)),
            ),
            trailing: new IconButton(
                icon: new Icon(Icons.delete),
                onPressed: () => widget.onDelete(workoutState.id)),
          ),
        ],
      )
    );
  }
}