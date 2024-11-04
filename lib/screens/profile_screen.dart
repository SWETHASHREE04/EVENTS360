import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  String? _profileImageUrl;
  bool isEditing = false;
  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        email = user.email;
      });
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_pics/${user.uid}.jpg');
        _profileImageUrl = await storageRef.getDownloadURL();
        setState(() {});
      } catch (e) {
        print('Failed to load profile image URL: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      // Show an alert if the platform is unsupported for image upload
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Platform Unsupported"),
          content:
              const Text("Image upload is only supported on Android and iOS."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pics/${user.uid}.jpg');
      await storageRef.putFile(_profileImage!);
      final downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        _profileImageUrl = downloadUrl;
      });
      print('Profile image uploaded: $_profileImageUrl');
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }

  Future<void> _updateEmailAndPassword() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      if (email != null && email!.isNotEmpty) {
        await user.updateEmail(email!);
      }
      if (password != null && password!.isNotEmpty) {
        await user.updatePassword(password!);
      }
      print('Email and Password updated');
    } catch (e) {
      print('Failed to update email or password: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFF6F61),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "PROFILE",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.grid_view, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black12,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : null,
                  child: _profileImageUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.black)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(Icons.camera_alt, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextFormField(
              initialValue: email ?? 'No email available',
              decoration: InputDecoration(
                labelText: 'EMAIL',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              readOnly: !isEditing,
              onChanged: (value) => email = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: '********',
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
              readOnly: !isEditing,
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                setState(() => isEditing = !isEditing);
                if (!isEditing) {
                  _updateEmailAndPassword();
                }
              },
              child: Text(isEditing ? 'SAVE' : 'EDIT'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
