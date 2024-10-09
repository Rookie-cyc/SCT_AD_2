import 'package:flutter/material.dart';

void main() {
  runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<String> tasks = []; // List to hold tasks

  // Method to add a task
  void addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        tasks.add(task); // Add task to the list
      });
    }
  }

  // Method to edit a task
  void editTask(int index, String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        tasks[index] = newTask; // Edit the task in the list
      });
    }
  }

  // Method to delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Remove task from the list
    });
  }

  // Method to show the dialog for adding or editing tasks
  void showTaskDialog({String initialTask = "", int? index}) {
    TextEditingController controller = TextEditingController(text: initialTask);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Task' : 'Edit Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter task here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(index == null ? 'Add' : 'Save'),
              onPressed: () {
                if (index == null) {
                  addTask(controller.text); // Add new task
                } else {
                  editTask(index, controller.text); // Edit existing task
                }
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => showTaskDialog(initialTask: tasks[index], index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteTask(index), // Delete task
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskDialog(), // Show dialog to add new task
        child: Icon(Icons.add),
      ),
    );
  }
}
