import 'package:flutter/material.dart';
import 'Screens/calculator.dart'; // Pastikan ini digunakan
import 'Screens/path.dart';
import 'Screens/video_player.dart';
import 'Screens/chat_screen.dart';
import 'Screens/temperature_converter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi-Feature App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Calculator(), // Menggunakan Calculator dari calculator.dart
    const PhoneBookApp(), // Pastikan Anda memiliki kelas ini
    const VideoPlayerScreen(), // Pastikan Anda memiliki kelas ini
    const ChatScreen(), // Pastikan Anda memiliki kelas ini
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Feature App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Phone Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Video Player',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat System',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Warna item yang dipilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        backgroundColor: Colors.white, // Warna latar belakang
        onTap: _onItemTapped,
      ),
    );
  }
}