import 'package:flutter/material.dart';

class CardChildTaskPage extends StatelessWidget {
  const CardChildTaskPage({
    @required this.icon,
    @required this.label,
    @required this.tasks,
  });

  final Icon icon;
  final String label;
  final String tasks;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 6),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: icon,
              radius: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Container(
              child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 8),
            child: Container(
              child: Text(
                tasks,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
          )
        ],
      ),
    );
  }
}
