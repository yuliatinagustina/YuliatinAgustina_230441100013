// screens/detail_page.dart
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> task;
  const DetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['judul'] ?? '-',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text("Kategori: ${task['kategori'] ?? '-'}"),
                SizedBox(height: 8),
                Text("Deadline: ${task['deadline'] ?? '-'}"),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/images/placeholder.png',
                    height: 160,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}