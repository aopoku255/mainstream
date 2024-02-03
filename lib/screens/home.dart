import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    void fetchUsers() async {
      print("Fetching users");
      final response =
          await http.get(Uri.parse("https://randomuser.me/api/?results=100"));
      final data = jsonDecode(response.body);
      setState(() {
        users = data['results'];
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final firstname = user['name']['first'];
            final lastname = user['name']['last'];
            final email = user['email'];
            final picture = user['picture']['thumbnail'];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  child: Image.network(picture),
                ),
              ),
              title: Row(
                children: [
                  Text(firstname),
                  Text("  "),
                  Text(lastname),
                ],
              ),
              subtitle: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: const Icon(Icons.download),
      ),
    );
  }
}
