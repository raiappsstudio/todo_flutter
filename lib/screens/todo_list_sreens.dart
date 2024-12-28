import 'package:flutter/material.dart';
import 'package:todo_flutter/screens/add_new_todo_screen.dart';
import 'package:todo_flutter/screens/todo.dart';
import 'package:todo_flutter/screens/update_todo_screen.dart';

class TodoListSreens extends StatefulWidget {
  const TodoListSreens({super.key});

  @override
  State<TodoListSreens> createState() => _TodoListSreensState();
}

class _TodoListSreensState extends State<TodoListSreens> {
  final List<Todo> listOfTodo = [];

  void _addTodo(Todo todo) {
    listOfTodo.add(todo);
    setState(() {});
  }

  void _deleteTodo(int index) {
    listOfTodo.removeAt(index);
    setState(() {});
  }

  void _updateTodo(int index, Todo todo) {
    listOfTodo[index] = todo;
    setState(() {});
  }

  void _updateTodostatus(int index, TodoStatus status) {
    listOfTodo[index].status = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List"),
        backgroundColor: Colors.green,
      ),
      body: Visibility(
        visible: listOfTodo.isNotEmpty,
        replacement:
            Center(child: Text("Empty List", style: TextStyle(fontSize: 25))),
        child: ListView.builder(
          itemCount: listOfTodo.length,
          itemBuilder: (context, index) {
            Todo todo = listOfTodo[index];
            return ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
              leading: Text(todo.status.name),
              trailing: Wrap(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  IconButton(
                      onPressed: () {
                        //_showChangestatus(context);

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Change Status"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text('Idle'),
                                      onTap: () {
                                        _updateTodostatus(
                                            index, TodoStatus.idle);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      title: Text('In Progress'),
                                      onTap: () {
                                        _updateTodostatus(
                                            index, TodoStatus.inProgress);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      title: Text('Done'),
                                      onTap: () {
                                        _updateTodostatus(
                                            index, TodoStatus.done);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.edit)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTodoScreen(
                      todoToBeUpdate: todo,
                      onUpdateTodo: (Todo updatedTodo) {
                        _updateTodo(index, updatedTodo);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Todo? todo = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewTodoScreen()));

            if (todo != null) {
              _addTodo(todo);
            }
          }),
    );
  }
}

void _showChangestatus(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Idle'),
                onTap: () {},
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                title: Text('In Progress'),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                title: Text('Done'),
              ),
            ],
          ),
        );
      });
}
