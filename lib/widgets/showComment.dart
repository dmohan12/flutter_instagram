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

class showComments extends StatefulWidget {
  List<Comment> comments;
  Post p;

  showComments(this.comments, this.p);
  @override
  _showCommentsState createState() => _showCommentsState();
}

class _showCommentsState extends State<showComments> {
  @override
  void initState() {
    //widget.comments.removeWhere((text)=> text.text == null);
  }

  Future<void> postComment(String text) async {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    if (text.length != 0) {
      var response = await http.post(
          "https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${widget.p.id}/comments?text=${text}",
          headers: {HttpHeaders.authorizationHeader: "Bearer ${bloc.token}"});

      if (response.statusCode == 200) {
        //call get comments request and recreate list of comments
        var response2 = await http.get(
            'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${widget.p.id}/comments');

        if (response2.statusCode == 200) {
          List<dynamic> serverPosts = json.decode(response.body);
          widget.comments =
              serverPosts.map((p) => Comment.fromJson(p)).toList();

          setState(() {});
        }
      }
    }
  }

  Future<void> deleteComment(int id)async{
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    var response= await http.delete('https://nameless-escarpment-45560.herokuapp.com/api/v1/comments/${id}',
    headers: {HttpHeaders.authorizationHeader: "Bearer ${bloc.token}"}
    );

    if(response.statusCode==202)
    {
      print("Comment deleted");
      widget.comments.removeWhere((comment) => comment.id==id);



    }
  }



  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text("Comments"),
          backgroundColor: Colors.black,
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(
                Icons.add_comment,
                color: Colors.white,
              ),
              onPressed: () {
                //add pop up box and to add comment

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController item = TextEditingController();
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Create Reminder"),
                      content: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              controller: item,
                              decoration: new InputDecoration(
                                  hintText: 'Enter ToDo Item'),
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Create",
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () async {
                            await postComment(item.text);

                            // await addItem(item.text,widget.token);

                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
      body: ListView.builder(
        itemCount: widget.comments.length,
        itemBuilder: (_, i) {
          Comment c = widget.comments[i];

          return Dismissible(
                  key: Key(UniqueKey().toString()),
                  background: Container(color: Colors.red),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction)  {
                    //await deleteItem(item.id, widget.token);
                    // add delete comment functio here


                    setState(() async{
                    await deleteComment(c.id);

                    });

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${c.text} dismissed")));
                  },
                  
        
                  child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(bloc.timeline
                  .firstWhere(
                      (item) => item.user_id == widget.comments[i].user_id)
                  .profile_image_url),
            ),
            title: Wrap(
              children: <Widget>[
                Text(c.text),
              ],
            ),
          ),
                );
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          // ListTile(
          //   leading: CircleAvatar(
          //     backgroundImage: NetworkImage(bloc.timeline
          //         .firstWhere(
          //             (item) => item.user_id == widget.comments[i].user_id)
          //         .profile_image_url),
          //   ),
          //   title: Wrap(
          //     children: <Widget>[
          //       Text(c.text),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
