import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRegistrationData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text("No registration data found."));
        }

        final registrationData = snapshot.data as Map<String, String>;

        return Scaffold(
          appBar: AppBar(title: Text("Registration Success")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Registration Successful!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Your Registration Details:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text('Event Title: ${registrationData['eventTitle']}'),
                Text('Name: ${registrationData['name']}'),
                Text('Email: ${registrationData['email']}'),
                Text('Enrollment: ${registrationData['enrollment']}'),
                Text('Phone: ${registrationData['phone']}'),
                SizedBox(height: 40),
                QrImageView(
                  data: _generateQrData(registrationData),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fetch the registration data from shared preferences
  Future<Map<String, String>> _getRegistrationData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'eventTitle': prefs.getString('eventTitle') ?? 'N/A',
      'name': prefs.getString('name') ?? 'N/A',
      'email': prefs.getString('email') ?? 'N/A',
      'enrollment': prefs.getString('enrollment') ?? 'N/A',
      'phone': prefs.getString('phone') ?? 'N/A',
    };
  }

  // Create a string to encode in the QR code
  String _generateQrData(Map<String, String> registrationData) {
    return '''
Event Title: ${registrationData['eventTitle']}
Name: ${registrationData['name']}
Email: ${registrationData['email']}
Enrollment: ${registrationData['enrollment']}
Phone: ${registrationData['phone']}
''';
  }
}
