import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Workout.dart';
import 'package:weight_tracker/database/AppDatabase.dart';

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
  void initState(){
    super.initState();
    workoutState = widget.workout;
  }

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      initiallyExpanded: workoutState.isExpanded ?? false,
      onExpansionChanged: (expanded) => workoutState.isExpanded = expanded,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.all(10.0),
          child: new RichText(
            text: new TextSpan(
              text: workoutState.description,
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w200,
                color: Colors.black
              )
            ),
          ),
        )
      ],
      leading: new Icon(
        Icons.alarm
      ),
      trailing: new IconButton(
        icon: new Icon(Icons.delete),
        onPressed: () => widget.onDelete(workoutState.id)
      ),
      title: new RichText(
        text:  new TextSpan(
          text: workoutState.title,
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}
