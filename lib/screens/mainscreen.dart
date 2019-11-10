import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/screens/mainfeed.dart';
import 'package:instagram_clone/screens/profilescreen.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/widgets/post-layout.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
    
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: new MaterialApp(home: new MainFeed()),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: new MaterialApp(
                home: new ProfileScreen(),
              ),
            ),
          ),
        ],

     
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.assignment_ind),
            title: new Text("My Profile"),
          ),
        ],
      ),
    );
  }
}
