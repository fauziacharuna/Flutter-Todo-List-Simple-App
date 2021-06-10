import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return new MaterialApp(
      title: 'Todo List',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Row(
            children: [
              GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  print("back");
                },
              ),
              Text("TodoList"),
              SizedBox()
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  // void _addTodoItems() {
  //   // Putting our code inside "setState" tells the app that our state has changed, and
  //   // it will automatically re-render the list
  //   setState(() {
  //     int index = _todoItems.length;
  //     _todoItems.add('Item ' + index.toString());
  //   });
  // }
  void _addTodoItems(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if (index < _todoItems.length) {
          if (_todoItems.isEmpty) {
            return Text("data is empty");
          }
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: "add Task",
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            controller: ,
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItems(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _removeTodoItem(int index) {
    //removing items from array todoItems
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Task : "${_todoItems[index]}" has done?'),
            actions: <Widget>[
              new TextButton(
                child: new Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              new TextButton(
                child: new Text('Done'),
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context);
                },
              )
            ],
          );
        });
  }

  void _resetState() {
    _todoItems = [];
  }
}
