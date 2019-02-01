import 'package:flutter/material.dart';
import 'package:unfound/Screens/All_Topics.dart';
import 'package:unfound/Screens/Home.dart';
import 'package:unfound/Screens/Liked_Topics.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;

  Home home;
  AllTopics allNews;
  LikedTopics saved;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    home = Home();
    allNews = AllTopics();
    saved = LikedTopics();

    pages = [home, allNews, saved];
    currentPage = home;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index){
          setState((){
            currentTab = index;
            currentPage = pages[index];
          });
        },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("All Topics")),
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Liked")),
          ]),
    );
  }
}

