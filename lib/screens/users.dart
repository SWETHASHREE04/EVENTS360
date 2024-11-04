import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // To remove the debug banner
      title: 'Users Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExploreEventsTable(),
    );
  }
}

class ExploreEventsTable extends StatelessWidget {
  final List<Map<String, String>> _users = [
    {"email": "ssharma289@rku.ac.in", "password": "swetha123"},
    {"email": "admin@rku.ac.in", "password": "admin123"},
    {"email": "edoshi831@rku.ac.in", "password": "esha123"},
    {"email": "kdhamecha541@rku.ac.in", "password": "keval123"},
    {"email": "votaradi213@rku.ac.in", "password": "viajy123"},
  ];

  ExploreEventsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6F61),
      appBar: AppBar(
        title: const Text('User Table'),
        backgroundColor: const Color(0xFFFF6F61),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                ),
              ],
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Password')),
              ],
              rows: _users
                  .map(
                    (user) => DataRow(
                      cells: [
                        DataCell(Text(user["email"]!)),
                        DataCell(Text(user["password"]!)), // Consider removing this in production
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
