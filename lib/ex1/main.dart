import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hobbies Demo',
      home: Scaffold(
        backgroundColor: Colors.grey[400], // page background similar to the mock
        appBar: AppBar(
          title: const Text('My Hobbies'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            // root padding as in the diagram
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // children take full width
              children: const [
                // single hobby card
                HobbyCard(
                  color: Color(0xFF39A94A), // green for Travelling
                  icon: Icons.flight_takeoff,
                  label: 'Travelling',
                ),
                SizedBox(height: 10),
                // second example card
                HobbyCard(
                  color: Color(0xFF607D8B), // blue-grey for Skating
                  icon: Icons.directions_run,
                  label: 'Skating',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  const HobbyCard({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // pill height; you can change to padding-based sizing if you prefer
      height: 64,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20), // rounded/pill shape
      ),
      child: Center(
        // Center ensures the Row is vertically centered inside the container
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // left padding around the icon (30 left, 20 right per suggestion)
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 20.0),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            // text takes remaining space and avoids overflow
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}