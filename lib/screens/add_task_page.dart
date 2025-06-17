// screens/add_task_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  String? selectedCategory;
  final dbRef = FirebaseDatabase.instance.ref("tugas");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Tugas'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(labelText: 'Deadline'),
              readOnly: true,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  deadlineController.text = picked.toLocal().toString().split(' ')[0];
                }
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Kategori'),
              items: ['Kuliah', 'Organisasi', 'Lainnya']
                  .map((cat) => DropdownMenuItem(
                        child: Text(cat),
                        value: cat,
                      ))
                  .toList(),
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    deadlineController.text.isNotEmpty &&
                    selectedCategory != null) {
                  dbRef.push().set({
                    "judul": titleController.text,
                    "deadline": deadlineController.text,
                    "kategori": selectedCategory,
                    "selesai": false,
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}