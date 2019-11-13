import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/comment.dart';

import 'package:http/http.dart' as http;
import 'package:instagram_clone/screens/userscreens.dart';
import 'dart:io';
import 'dart:convert';

import 'package:instagram_clone/widgets/showComment.dart';



class CommentsPage extends StatefulWidget {
  List<Comment> comments;
  Post p;

  CommentsPage(this.comments,this.p);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

            appBar: AppBar(title: Text("Comments"),),
            body:Container(
              child: Column(
                children: <Widget>[

                  showComments(widget.comments, widget.p),

                  //FormField(),
                ],
              ),
              
            ),
    );
    

  }
}
