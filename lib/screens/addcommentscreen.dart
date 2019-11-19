import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/comment.dart';

import 'package:instagram_clone/widgets/post-layout.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/screens/userscreens.dart';
import 'dart:io';
import 'dart:convert';

import 'package:provider/provider.dart';

class AddComment extends StatefulWidget {
  @override

  Post p;
  AddComment(this.p);
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController comments = TextEditingController();
  List<Comment> allComments = [];

  Future<void> postComment(String text) async {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    if (text.length != 0) {
      var response = await http.post(
          "https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${widget.p.id}/comments?text=${text}",
          headers: {HttpHeaders.authorizationHeader: "Bearer ${bloc.token}"});

      if (response.statusCode == 200) {
        //call get comments request and recreate list of comments

        print("COMMENT ADDED YEET");
        var response2 = await http.get(
            'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${widget.p.id}/comments');

        if (response2.statusCode == 200) {
          List<dynamic> serverPosts = json.decode(response.body);
          allComments = serverPosts.map((p) => Comment.fromJson(p)).toList();

          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Comment"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: comments,
            decoration: InputDecoration(
                labelText: "Comment",
                hintText: "Enter Comment",
                prefixIcon: Icon(Icons.add_comment),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),

          RaisedButton(
            child: Text('Submit'),
            onPressed: ()async{

              await postComment(comments.text);
              Navigator.pop(context, allComments);
            },
          )
        ],
      ),
    );
  }
}
