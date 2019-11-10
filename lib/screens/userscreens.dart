import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/widgets/post-layout.dart';
import 'package:http/http.dart' as http;



class UserScreens extends StatefulWidget {
  @override
  final List<Post> items;

  UserScreens(this.items);

  _UserScreensState createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {



  @override
  Widget build(BuildContext context) {

       return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(title: Text("Instagram"),
      
      actions: <Widget>[
        Padding(padding: EdgeInsets.only(right: 40),),
        IconButton(icon: Icon(Icons.settings),
        onPressed: (){
         
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => Settings()),);
        },
        
        ),
      ],
      ),
    body: ListView.builder(
      //change to timeline.length to show everyones post
      itemCount: widget.items.length,
      itemBuilder: (_,i){
        Post p = widget.items[i];
        return ShowPost(p);
      },
    ),
    
    );
  
  }
}