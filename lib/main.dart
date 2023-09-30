import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo App",
      home: ToDo(),
    );
  }
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

List<Task> taskLists = [];

TextEditingController taskController = TextEditingController();

class _ToDoState extends State<ToDo> {
  Color bgColor = const Color(0XFFEEEFF5);
  Color blueColor = const Color(0XFF5F52EE);

  addTasks(String task) {
    setState(() {
      taskLists.add(Task(taskText: task));
    });
    taskController.clear();
  }

  deleteTasks(int index) {
    setState(() {
      taskLists.removeAt(index);
    });
  }

  toggle(int index) {
    setState(() {
      taskLists[index].icCompleted = !taskLists[index].icCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset("assets/images/profile.jpeg"),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(
                    controller: taskController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.notes),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red)),
                      filled: true,
                      fillColor: bgColor,
                      hintText: "Enter Task",
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: IconButton(
                    onPressed: () {
                      if (taskController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Your Task Field is empty")));
                      } else {
                        addTasks(taskController.text);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.red,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              "All ToDos",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskLists.length,
              itemBuilder: (context, index) {
                final task = taskLists[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    tileColor: Colors.white,
                    leading: GestureDetector(
                      onTap: () {
                        toggle(index);
                      },
                      child: Icon(
                        task.icCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: blueColor,
                      ),
                    ),
                    title: Text(
                      task.taskText,
                      style: TextStyle(
                          decoration: task.icCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        deleteTasks(index);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16)),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Task {
  String taskText;
  bool icCompleted;
  Task({
    required this.taskText,
    this.icCompleted = false,
  });
}
