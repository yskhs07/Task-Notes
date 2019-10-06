import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

TextEditingController textFieldController;

class AddTask extends StatefulWidget {
  static String id = 'addtask';
  final String title;
  AddTask({this.title});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFAFDFDFD),
          title: Center(
              child: Text(
            'ADD ITEM',
            style: TextStyle(fontFamily: 'FredokaOne', color: Colors.black),
          )),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    child: Text(
                  'What are you planning?',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black87, fontSize: 20.0),
                )),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textFieldController,
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: (BorderRadius.circular(14)),
                        borderSide:
                            BorderSide(color: Colors.grey[500], width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: (BorderRadius.circular(14)),
                        borderSide:
                            BorderSide(color: Colors.grey[500], width: 2)),
                  ),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  showCursor: true,
                  cursorColor: Colors.grey[600],
                  cursorRadius: Radius.circular(10.0),
                  cursorWidth: 10.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: CreateButton(
                onTap: () {
                  if (textFieldController.text.isNotEmpty)
                    Navigator.pop(context, textFieldController.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final Function onTap;

  const CreateButton({@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          margin: EdgeInsets.only(top: 20),
          width: double.infinity,
          child: Center(
            child: Text(
              'CREATE',
              style: TextStyle(fontFamily: 'FredokaOne', fontSize: 20),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.lightBlue,
          )),
    );
  }
}
