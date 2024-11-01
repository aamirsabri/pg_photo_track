import 'package:flutter/material.dart';
import 'package:pg_photo_track/presentation/route_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: const Text('Welcome to the Home Screen!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define what happens when the button is pressed
          print('Floating Action Button Pressed');
          Navigator.pushNamed(context, Routes.visetDetail);
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Optional: position of the button
    );
  }
}
