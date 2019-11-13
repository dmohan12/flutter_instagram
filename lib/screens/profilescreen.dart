import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/widgets/post-layout.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
   InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        leading: Icon(Icons.camera_alt),
        centerTitle: true,
        title: Text(
          "Instagram",
          style: TextStyle(fontFamily: 'Billabong', fontSize: 35),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.live_tv),
            onPressed: () {},
          ),
          // action button
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          ),
          // overflow men
        ],
      ),
    body: ListView.builder(
      //change to timeline.length to show everyones post
      itemCount: bloc.my_posts.length,
      itemBuilder: (_,i){
        Post p = bloc.my_posts[i];
        return ShowPost(p);
      },
    ),
    
       /* bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text("sdsd"),
        
        ),
      ],
      //currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
     // onTap: _onItemTapped,
    ),*/
    
    );
  }
}