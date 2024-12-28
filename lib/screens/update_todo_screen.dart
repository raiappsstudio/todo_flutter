import 'package:flutter/material.dart';
import 'package:todo_flutter/screens/todo.dart';

class UpdateTodoScreen extends StatefulWidget {
  const UpdateTodoScreen(
      {super.key, required this.todoToBeUpdate, required this.onUpdateTodo});

  final Todo todoToBeUpdate;
  final Function(Todo) onUpdateTodo;

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleTEController.text = widget.todoToBeUpdate.title;
    _descriptionTEController.text = widget.todoToBeUpdate.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Todo"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "title", hintText: "write your todo title"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'enter your title';
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 3,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "write your todo Description"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'enter your description';
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Todo todo = Todo(
                            title: _titleTEController.text.trim(),
                            description: _descriptionTEController.text.trim(),
                            status: widget.todoToBeUpdate.status);

                        widget.onUpdateTodo(todo);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Updated"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
