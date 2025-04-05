import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void addItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen(callback: addTask)),
    );
  }

  void addTask(Task task) {
    try {
      FirebaseFirestore.instance.collection("tasks").add({
        "title": task.title,
        "description": task.description,
        "isCompleted": false,
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteTask(String id) {
    try {
      FirebaseFirestore.instance.collection("tasks").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("These are your tasks:"),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("tasks").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Text("No data");
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Task currentTask = Task(
                        description:
                            snapshot.data!.docs[index].data()["description"],
                        title: snapshot.data!.docs[index].data()["title"],
                        id: snapshot.data!.docs[index].id,
                      );
                      return TaskTile(
                        task: currentTask,
                        deletionCallback: deleteTask,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        tooltip: 'Add New Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.deletionCallback,
  });
  final Task task;
  final Function(String id) deletionCallback;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: CheckboxListTile(
                value: widget.task.isCompleted,
                onChanged: (bool? newValue) {
                  setState(() {
                    widget.task.isCompleted = newValue ?? false;
                  });
                },
                title: Text(widget.task.title),
                subtitle: Text(widget.task.description),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton.filled(
                icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: () => widget.deletionCallback(widget.task.id!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.callback});
  final Function(Task task) callback;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void submit(context) {
    widget.callback(
      Task(
        description: descriptionController.text,
        title: titleController.text,
      ),
    );
    descriptionController.clear();
    titleController.clear();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: "Description"),
            ),
            TextButton(
              onPressed: () => submit(context),
              child: Text("Add task"),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool isCompleted;
  String description;
  String? id;
  Task({
    required this.title,
    required this.description,
    this.id,
    this.isCompleted = false,
  });
}
