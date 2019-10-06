import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';
import 'addTask.dart';
import 'card.dart';

class HomePage extends StatefulWidget {
  static String id = 'homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalTodo = 3;
  List<Todo> list = List<Todo>();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    list.add(Todo(title: 'Sample Item', isComplete: false));
    list.add(Todo(title: 'Swipe Right To Delete >>>>>>', isComplete: false));
    list.add(Todo(title: 'Long Press To Edit Item', isComplete: false));

    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: goToItemView,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(29),
                    topLeft: Radius.circular(29),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 210.0),
                  child: list.isNotEmpty ? buildBody() : buildEmptyBody(),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: CardChildTaskPage(
                      icon: Icon(
                        FontAwesomeIcons.clipboard,
                        size: 28,
                      ),
                      label: 'All Tasks',
                      tasks: getTotalTodo())),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildTask(list[index]);
      },
    );
  }

  Widget buildEmptyBody() {
    return Center(
      child: Container(
        child: Text(
          'No Items',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildTask(Todo item) {
    return Dismissible(
      key: Key(item.hashCode.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 5),
        color: Colors.grey[400],
        child: Icon(Icons.delete),
        alignment: Alignment.centerLeft,
      ),
      onDismissed: (direction) => removeItem(item),
      child: buildListView(item),
    );
  }

  Widget buildListView(Todo item) {
    return ListTile(
      title: Text(item.title),
      trailing: Checkbox(value: item.isComplete, onChanged: null),
      onTap: () => setComplete(item),
      onLongPress: () => goToEditItem(item),
    );
  }

  void goToEditItem(Todo item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddTask(
            title: item.title,
          );
        },
      ),
    ).then((title) {
      if (title != null) editTodo(item, title);
    });
  }

  void goToItemView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddTask();
        },
      ),
    ).then((title) {
      if (title != null) addTodo(Todo(title: title, isComplete: false));
    });
  }

  void setComplete(Todo item) {
    setState(() {
      item.isComplete = !item.isComplete;
    });
    saveData();
  }

  void addTodo(Todo item) {
    list.add(item);
    saveData();
  }

  void editTodo(Todo item, String title) {
    item.title = title;
    saveData();
  }

  void removeItem(Todo item) {
    list.remove(item);
    if (list.isEmpty) setState(() {});
    saveData();
    setState(() {});
  }

  void saveData() {
    List<String> spList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', spList);
    totalTodo = list.length;
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    list = spList.map((item) => Todo.fromMap(json.decode(item))).toList();
    totalTodo = list.length;
    setState(() {});
  }

  String getTotalTodo() {
    return '$totalTodo Tasks';
  }
}
