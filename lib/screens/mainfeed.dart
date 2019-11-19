import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/widgets/post-layout.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class MainFeed extends StatefulWidget {
  @override
  _MainFeed createState() => _MainFeed();
}

class _MainFeed extends State<MainFeed> {
  Future<List<Post>> getUserPost(int id, String token) async {
    List<Post> items = [];

    var response = await http.get(
        "https://nameless-escarpment-45560.herokuapp.com/api/users/$id",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200) {
      List<dynamic> serverPosts = json.decode(response.body);
      for (int i = 0; i < serverPosts.length; i++) {
        items.add(Post.fromJson(serverPosts[i]));
      }
// makes request to get a specific users posts. Build a listview out of users post
    }

    return items;
  }

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
        itemCount: bloc.timeline.length,
        itemBuilder: (_, i) {

          
          Post p = bloc.timeline[i];
          return ShowPost(p);
        },
      ),
    );
  }
}
