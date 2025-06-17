// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'add_task_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseDatabase.instance.ref("tugas");
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final temp = data.entries.map((e) {
          final val = Map<String, dynamic>.from(e.value);
          val['key'] = e.key;
          return val;
        }).toList();
        setState(() => tasks = temp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List Mahasiswa')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(task: task),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(task['judul'] ?? ''),
                subtitle: Text(task['kategori'] ?? ''),
                trailing: Checkbox(
                  value: task['selesai'] ?? false,
                  onChanged: (val) {
                    dbRef.child(task['key']).update({"selesai": val});
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
} 