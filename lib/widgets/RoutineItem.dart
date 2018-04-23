import 'package:flutter/material.dart';
import 'package:weight_tracker/models/Routine.dart';
import 'package:weight_tracker/database/AppDatabase.dart';

class RoutineItem extends StatefulWidget {

  final Routine routine;
  final Function onDelete;

  RoutineItem(this.routine, {this.onDelete});

  @override
  RoutineItemState createState() => new RoutineItemState();
}

class RoutineItemState extends State<RoutineItem> {
  Routine routineState;
  AppDatabase db = new AppDatabase();

  @override
  void initState(){
    super.initState();
    routineState = widget.routine;
  }

  void updateRoutine() async {
    AppDatabase db = new AppDatabase();
    db.updateRoutine(routineState);
  }

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      initiallyExpanded: routineState.isExpanded ?? false,
      onExpansionChanged: (expanded) => routineState.isExpanded = expanded,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.all(10.0),
          child: new RichText(
            text: new TextSpan(
              text: routineState.notes,
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
        onPressed: () => widget.onDelete(routineState.id)
      ),
      title: new Column(
        children: <Widget>[
          new TextFormField(
            decoration: new InputDecoration(
              hintText: routineState.weight.toString()
            ),
            initialValue: routineState.weight.toString(),
            onSaved: (text) => routineState.weight = double.parse(text),
          ),
          new RichText(
            text: new TextSpan(
              text: "x"
            ),
          ),
          new TextFormField(
            decoration: new InputDecoration(
              hintText: routineState.reps.toString()
            ),
            initialValue: routineState.reps.toString(),
            onSaved: (text) => routineState.reps = double.parse(text),
          ),
        ],
      )
    );
  }
}
