import 'package:flutter/material.dart';
import 'calender_screen.dart';
import 'profile_screen.dart';
import 'explore_screen.dart';
import 'popular_events.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyEventsPage(),
    );
  }
}

class MyEventsPage extends StatefulWidget {
  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  int _selectedIndex = 1;

  // List of widget pages to navigate to

  // Method to handle tap on BottomNavigationBarItem
  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CalendarScreen()), // Navigate to the CalendarScreen
      );
    } else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PopularEventsPage()), // Navigate to the Profile page
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ExplorePage()), // Navigate to the Profile page
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProfileScreen()), // Navigate to the Profile page
      );
    }
    else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // Method to show status widget as a bottom sheet with vertical steps
  void _showStatus(String status) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stack to align the vertical line with the items
              Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2, // Width of the vertical line
                      color: Colors.black, // Color of the line
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                      bottom: 10,
                    ), // Padding to push the content right
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatusItem("Register", true),
                        _buildStatusItem("Pay the Charges", false),
                        _buildStatusItem("Confirmed", false),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusItem(String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            isActive
                ? Icons.check_circle
                : Icons.radio_button_unchecked, // Active or inactive state
            color: isActive ? Colors.green : Colors.grey,
          ),
          SizedBox(width: 8),
          Padding(
            padding: EdgeInsets.only(bottom: 30), // Adjust padding as needed
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive
                    ? Colors.black
                    : Colors.grey, // Change color based on status
              ),
            ),
          ),
        ],
      ),
    );
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
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
                onTap: () => _showStatus(
                    'Status: Register > Pay the Charges > Confirmed'),
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
                onTap: () => _showStatus(
                    'Status: Register > Submit Photos > Winner Announcement'),
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
                onTap: () => _showStatus(
                    'Status: Register > Audition > Final Performance'),
              ),
              EventCard(
                title: 'My Events',
                date: 'Coming Soon',
                description: 'Stay tuned for upcoming events.',
                imageWidget: Icon(Icons.event, size: 100),
                backgroundColor: Colors.pink[100]!,
                onTap: () => _showStatus('Status: Coming Soon'),
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
        constraints: BoxConstraints(
          minHeight: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                imageWidget,
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (daysRemaining != null)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  daysRemaining!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
