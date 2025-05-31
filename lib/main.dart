import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment 4',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Assignment 4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl = '';

  Future<void> fetchDogImage() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    }
  }

  Future<void> fetchCatImage() async {
    final response =
        await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imageUrl = data[0]['url'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl.isNotEmpty)
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Text('Press a button to load an image!',
                style: TextStyle(fontSize: 18)),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    fetchDogImage();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, elevation: 8),
                  child: Text('Get Dog',
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    fetchCatImage();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, elevation: 8),
                  child: Text('Get Cat',
                      style: TextStyle(fontSize: 25, color: Colors.white))),
            ],
          )
        ],
      ),
    );
  }
}
