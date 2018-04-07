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
              text: routineState.description,
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
      title: new RichText(
        text:  new TextSpan(
          text: routineState.title,
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
