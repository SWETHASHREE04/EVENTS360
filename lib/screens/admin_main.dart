import 'package:flutter/material.dart';
import 'popular_form.dart';
import 'explore_form.dart';
import 'calendar_form.dart';
import 'users.dart';
import 'qr.dart';
// Assuming you will create the ScanQRPage or import it.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Events',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFFF6F61), // Background similar to the screenshot

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              text: 'USER',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExploreEventsTable()));
              },
            ),
            SizedBox(height: 20), // Spacing between buttons
            MenuButton(
              text: 'POPULAR EVENTS',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PopularEventsForm()));
              },
            ),
            SizedBox(height: 20),
            MenuButton(
              text: 'EXPLORE EVENTS',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExploreEventsForm()));
              },
            ),
            SizedBox(height: 20),
            MenuButton(
              text: 'CALENDAR',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalendarForm()));
              },
            ),
            SizedBox(height: 20),
            MenuButton(
              text: 'SCAN QR', // Added Scan QR Button
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanQRPage()));
              },
            ),
            SizedBox(height: 20), // Space between Scan QR and Logout
            MenuButton(
              text: 'LOGOUT',
              onPressed: () {
                // Handle logout action
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MenuButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300], // Grey button background
        padding: EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 0.0), // Removed left and right padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity, // Make the button stretch to full width
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black, // Black text as seen in the image
              fontSize: 18.0, // Font size similar to the screenshot
            ),
          ),
        ),
      ),
    );
  }
}

// Define dummy pages to navigate to
class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Page')),
      body: Center(child: Text('This is the User Page')),
    );
  }
}

class PopularPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Events Page')),
      body: Center(child: Text('This is the Popular Events Page')),
    );
  }
}

class ExploreEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Events Page')),
      body: Center(child: Text('This is the Explore Events Page')),
    );
  }
}

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar Page')),
      body: Center(child: Text('This is the Calendar Page')),
    );
  }
}

// Dummy ScanQRPage (Replace with your actual Scan QR implementation)
class ScanQrRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Page')),
      body: Center(child: Text('This is the Scan QR Page')),
    );
  }
}
