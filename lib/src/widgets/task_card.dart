import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  @override
  _TaskCardState createState() => _TaskCardState();
  final String noteDescription;
  final String noteTitle;

  const TaskCard({Key key, this.noteDescription, this.noteTitle})
      : super(key: key);
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.check_box_outline_blank,
              color: Colors.grey,
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.noteTitle, style: TextStyle(fontSize: 16.0)),
                SizedBox(
                  height: 5.0,
                ),
                Text(widget.noteDescription, style: TextStyle(fontSize: 12.0))
              ],
            ),
            IconButton(icon: Icon(Icons.delete_forever),color: Colors.red,onPressed: (){

            },)
          ],
        ),
      ),
    );
  }
}
