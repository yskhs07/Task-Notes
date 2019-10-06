class Todo {
  Todo({this.isComplete, this.title});
  String title;
  bool isComplete = false;

  Todo.fromMap(Map map)
      : this.title = map['title'],
        this.isComplete = map['isComplete'];

  Map toMap() {
    return {
      'title': this.title,
      'isComplete': this.isComplete,
    };
  }
}
