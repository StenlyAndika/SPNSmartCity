import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import '../../preferences/database.dart';
import '../../../widgets/header.dart';

class DaftarTugas extends StatefulWidget {
  const DaftarTugas({super.key});

  static const nameRoute = '/todo';

  @override
  State<DaftarTugas> createState() => _DaftarTugasState();
}

class _DaftarTugasState extends State<DaftarTugas> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tugas Baru",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: saveNewTask,
                      color: const Color.fromARGB(255, 3, 65, 180),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    MaterialButton(
                      onPressed: () => Navigator.of(context).pop(),
                      color: const Color.fromARGB(255, 3, 65, 180),
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(255, 3, 65, 180),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 65, 180),
      body: ListView(
        children: [
          const Header(
              title: "Daftar Tugas",
              subtitle: "kelola aktivitas anda secara teratur"),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => deleteTask(index),
                          icon: Icons.delete,
                          backgroundColor: const Color(0xFFFE4A49),
                          borderRadius: BorderRadius.circular(12),
                        )
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff1D1617).withOpacity(0.1),
                            blurRadius: 2,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: db.toDoList[index][1],
                            onChanged: (value) => checkBoxChanged(value, index),
                            activeColor: Colors.black,
                          ),
                          Expanded(
                            child: Text(
                              db.toDoList[index][0],
                              style: TextStyle(
                                decoration: db.toDoList[index][1]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                              db.toDoList[index][1]
                                  ? 'Selesai'
                                  : 'Belum Selesai',
                              style: db.toDoList[index][1]
                                  ? const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)
                                  : const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
