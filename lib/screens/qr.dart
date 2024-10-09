import 'package:flutter/material.dart';

class ScanQRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: Color(0xFFFF6F61), // Set the AppBar color
      ),
      backgroundColor:
          Color.fromARGB(255, 254, 253, 253), // Set the background color
      body: Center(
        // Centering the entire body content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center contents vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center contents horizontally
            children: [
              SizedBox(height: 20),
              Text(
                'Hold your camera up to the QR code',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Align text to the center
              ),
              SizedBox(height: 10),
              Text(
                'Position the QR code within the frame to scan.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center, // Align text to the center
              ),
              SizedBox(height: 40),

              // QR Code Scanning Area (Placeholder for actual scanning)
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 150,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 40),

              // Simulate QR Scan Button
              ElevatedButton.icon(
                onPressed: () {
                  // Add functionality to scan the QR code here
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Scanning...'),
                  ));
                },
                icon: Icon(Icons.camera_alt),
                label: Text('Start Scanning'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),

              // Manual Input Option
              TextButton(
                onPressed: () {
                  // Add functionality for manual input
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Enter QR Code Manually'),
                        content: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter code here',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Enter Code Manually'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
