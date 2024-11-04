import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExploreEventsTable(),
    );
  }
}

// Function to register a user and store their email and UID in Firestore
Future<void> registerUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Store user info in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': email,
      'uid': userCredential.user!.uid,
    });
  } catch (e) {
    print("Error registering user: $e");
  }
}

class ExploreEventsTable extends StatelessWidget {
  const ExploreEventsTable({super.key});

  // Fetches user data from Firestore
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final List<Map<String, dynamic>> users = [];
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (var doc in querySnapshot.docs) {
        users.add(doc.data());
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6F61),
      appBar: AppBar(
        title: const Text('User Table'),
        backgroundColor: const Color(0xFFFF6F61),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          final users = snapshot.data!;
          return Padding(
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
                    DataColumn(label: Text('User ID')),
                  ],
                  rows: users
                      .map(
                        (user) => DataRow(
                          cells: [
                            DataCell(Text(user["email"] ?? '')),
                            DataCell(Text(user["uid"] ?? '')),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
