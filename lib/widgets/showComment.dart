import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/comment.dart';

import 'package:http/http.dart' as http;
import 'package:instagram_clone/screens/userscreens.dart';
import 'dart:io';
import 'dart:convert';

import 'package:provider/provider.dart';

class showComments extends StatefulWidget {
  List<Comment> comments;
  
  showComments(this.comments);
  @override
  _showCommentsState createState() => _showCommentsState();
}

class _showCommentsState extends State<showComments> {
  @override
  void initState() {
    //widget.comments.removeWhere((text)=> text.text == null);
  }
  @override
  
  Widget build(BuildContext context) {
        InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    

    return Scaffold(

      appBar: AppBar(title: Text("Comments"),),

      body: ListView.builder(
        itemCount: widget.comments.length,
        itemBuilder: (_, i) {
          Comment c = widget.comments[i];

          return ListTile(
              leading:  CircleAvatar(

                backgroundImage: NetworkImage(bloc.timeline.firstWhere((item)=> item.user_id==widget.comments[i].user_id).profile_image_url),
              ), 
            title: Wrap(
            children: <Widget>[
              Text(c.text),
            ],
          ),
          );
          
          
          
        },
      ),
    );
  }
}
