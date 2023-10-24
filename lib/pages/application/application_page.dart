import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yt_ulearning/pages/application/application_widgets.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(0),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {},
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                    backgroundColor: Colors.red),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book_outlined), label: 'Course'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_outlined), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: 'Profile'),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ));
  }
}
