// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'calender_screen.dart';
import 'profile_screen.dart';
import 'explore_screen.dart';
import 'popular_events.dart';
import 'payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'retrieve.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyEventsPage(),
    );
  }
}

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarScreen()),
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PopularEventsPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExplorePage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6F61),
      appBar: AppBar(
        title: Text(
          'My Events',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 2,
            children: [
              EventCard(
                title: 'Enhance your Business skills',
                date: '20 July',
                description: 'Participate in Food Fest, Art exhibition, etc.',
                daysRemaining: '2 Days',
                imageWidget: Image.network(
                  'https://cdn.shopify.com/s/files/1/0840/8370/3830/articles/1603898293-shutterstock598993493.jpg?v=1714646550',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.orange[100]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventRegistrationForm(
                      eventTitle: 'Enhance your Business skills',
                      isPaymentRequired: true,
                    ),
                  ),
                ),
              ),
              EventCard(
                title: 'Nature Photography',
                date: '12 June',
                description:
                    'Submit photos of campus nature for a chance to win.',
                imageWidget: Image.network(
                  'https://cdn.pixabay.com/photo/2017/09/01/13/56/university-2704306_640.jpg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.lightBlue[100]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventRegistrationForm(
                      eventTitle: 'Nature Photography',
                      isPaymentRequired: false,
                    ),
                  ),
                ),
              ),
              EventCard(
                title: 'Unsaid Events',
                date: '20 July',
                description:
                    'Musical events for hidden talents. Register to showcase your own talent.',
                imageWidget: Image.network(
                  'https://images.pexels.com/photos/976866/pexels-photo-976866.jpeg?cs=srgb&dl=pexels-joshsorenson-976866.jpg&fm=jpg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.green[100]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventRegistrationForm(
                      eventTitle: 'Unsaid Events',
                      isPaymentRequired: false,
                    ),
                  ),
                ),
              ),
              EventCard(
                title: 'My Events',
                date: 'Coming Soon',
                description: 'Stay tuned for upcoming events.',
                imageWidget: Icon(Icons.event, size: 100),
                backgroundColor: Colors.pink[100]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventRegistrationForm(
                      eventTitle: 'My Events',
                      isPaymentRequired: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'My Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String? daysRemaining;
  final Widget imageWidget;
  final Color backgroundColor;
  final VoidCallback onTap;

  EventCard({
    required this.title,
    required this.date,
    required this.description,
    this.daysRemaining,
    required this.imageWidget,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(minHeight: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageWidget,
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              date,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            Text(description, style: TextStyle(fontSize: 14)),
            if (daysRemaining != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '$daysRemaining remaining',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onTap,
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventRegistrationForm extends StatefulWidget {
  final String eventTitle;
  final bool isPaymentRequired;

  EventRegistrationForm({
    required this.eventTitle,
    required this.isPaymentRequired,
  });

  @override
  _EventRegistrationFormState createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _enrollmentController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isEmailValid(String email) {
    return email.endsWith('@rku.ac.in');
  }

  bool isPhoneValid(String phone) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      // Store registration data temporarily
      await prefs.setString('eventTitle', widget.eventTitle);
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('enrollment', _enrollmentController.text);
      await prefs.setString('phone', _phoneController.text);

      // Firestore collection for storing registrations
      final registrationsCollection =
          FirebaseFirestore.instance.collection('registrations');

      // Create a new document in Firestore for this registration
      await registrationsCollection.add({
        'eventTitle': widget.eventTitle,
        'name': _nameController.text,
        'email': _emailController.text,
        'enrollment': _enrollmentController.text,
        'phone': _phoneController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      if (widget.isPaymentRequired) {
        // Pass the required arguments to PaymentPage
        final bool? paymentSuccess = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              eventTitle: widget.eventTitle,
              email: _emailController.text,
              phone: _phoneController.text,
            ),
          ),
        );
        if (paymentSuccess == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegistrationSuccessScreen()),
          );
        } else {
          _showPaymentError();
        }
        // Navigate to payment if needed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registered successfully!")),
        );
        Navigator.pop(context);
      }
    }
  }

  void _showPaymentError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Cancelled/Failed"),
        content: Text("Payment was unsuccessful. Please try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _enrollmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register for ${widget.eventTitle}'),
        backgroundColor: Color(0xFFFF6F61),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your full name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'University Email'),
                validator: (value) => !isEmailValid(value ?? '')
                    ? 'Invalid university email'
                    : null,
              ),
              TextFormField(
                controller: _enrollmentController,
                decoration: InputDecoration(labelText: 'Enrollment Number'),
                validator: (value) => value!.isEmpty
                    ? 'Please enter your enrollment number'
                    : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    !isPhoneValid(value ?? '') ? 'Invalid phone number' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: handleSubmit,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F61),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
