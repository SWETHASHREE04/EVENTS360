import 'package:flutter/material.dart';
import 'calender_screen.dart';
import 'profile_screen.dart';
import 'myevents.dart';
import 'explore_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopularEventsPage(),
    );
  }
}

class PopularEventsPage extends StatefulWidget {
  @override
  _PopularEventsPageState createState() => _PopularEventsPageState();
}

class _PopularEventsPageState extends State<PopularEventsPage> {
  int _selectedIndex = 0;

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
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyEventsPage()), // Navigate to the Profile page
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
    } /* else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to the Profile page
            );
    }*/
    else {
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
          'Popular Events',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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

  EventCard({
    required this.title,
    required this.date,
    required this.description,
    this.daysRemaining,
    required this.imageWidget,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
