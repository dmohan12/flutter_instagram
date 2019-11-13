import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/comment.dart';

import 'package:http/http.dart' as http;
import 'package:instagram_clone/screens/userscreens.dart';
import 'package:instagram_clone/widgets/showComment.dart';
import 'package:instagram_clone/screens/commentspage2.dart';

import 'dart:io';
import 'dart:convert';

import 'package:provider/provider.dart';

class ShowPost extends StatefulWidget {
  Post post;
  List<Post> items;
  List<Comment> comments;

  ShowPost(this.post);

  @override
  _ShowPostState createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {

  String checkProfileImage(String image_url) {
    if (image_url == null) {
      String placeholder =
          "http://www.racemph.com/wp-content/uploads/2016/09/profile-image-placeholder-300x300.png";
      return placeholder;
    } else
      return image_url;
  }

 void postComment(String comment) async {
    if (comment.length != 0) {
      // var response= await http
    }
  }

  Future<void> getComments(int id) async {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    var response = await http.get(
        'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${id}/comments',
        headers: {HttpHeaders.authorizationHeader: "Bearer ${bloc.token}"});
    if (response.statusCode == 200) {
      List<dynamic> serverPosts = json.decode(response.body);
      // for (int i = 0; i < serverPosts.length; i++) {
      //   widget.items.add(Post.fromJson(serverPosts[i]));

      // }
      
      widget.comments = serverPosts.map((p) => Comment.fromJson(p)).toList();
      //  for (int i = 0; i < serverPosts.length; i++) {
      //    widget.comments.add(serverPosts[i]);
      //    print("Item: "+i.toString());
      //  }
      // print("Got user postsss: ${widget.items.length}");
    }
  }

  // @override
  // void initState(){
  //     getComments(widget.post.id);
  //   //print(widget.comments.length);
  // }

  Future<void> getUserPost(int id, String token) async {
    var response = await http.get(
        "https://nameless-escarpment-45560.herokuapp.com/api/v1/users/${id}/posts",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200) {
      List<dynamic> serverPosts = json.decode(response.body);
      // for (int i = 0; i < serverPosts.length; i++) {
      //   widget.items.add(Post.fromJson(serverPosts[i]));

      // }
      widget.items = serverPosts.map((p) => Post.fromJson(p)).toList();

      print("Got user postsss: ${widget.items.length}");

// makes request to get a specific users posts. Build a listview out of users post
    }
  }

 

  Future<void> deletePost(int id) async {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    if (widget.post.user_id == bloc.myAccount.id) {
      var response = await http.delete(
          'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${id}',
          headers: {HttpHeaders.authorizationHeader: "Bearer ${bloc.token}"});

      if (response.statusCode == 202) {
        print("current posts : ${bloc.my_posts.length}");
        print("post DELETED");

        bloc.my_posts.removeWhere((item) => item.id == id);
        bloc.timeline.removeWhere((item) => item.id == id);

        bloc.notifyListeners();
      }
    }
  }

  //int x=widget.post.user_id;

  String menuItem = "deleted";
  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    //getUserPost(widget.post.user_id, bloc.token);
    //getUserPost(widget.post.user_id, bloc.token);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10, left: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      checkProfileImage(widget.post.profile_image_url)),
                ),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: () async {
                        await getUserPost(widget.post.user_id, bloc.token);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserScreens(widget.items),
                          ),
                        );
                      },
                      child: Text(
                        widget.post.username,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Spacer(),
                Container(
                  child: DropdownButton<String>(
                    value: null,
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),

                    iconSize: 40,
                    // elevation: 16,

                    onChanged: (String newValue) {
                      this.menuItem = newValue;

                      if (newValue == "Delete") {
                        deletePost(widget.post.id);
                      }

                      setState(() {
                        //  dropdownValue = newValue;
                        // bloc.my_posts.removeWhere((item)=> item.id==widget.post.id);
                        //notifyListeners();

                        print("current posts : ${bloc.my_posts.length}");
                      });
                    },
                    items: <String>['Delete', "User Page"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  //   alignment: Alignment.topRight,
                  // child: IconButton(icon: Icon(Icons.more_horiz),color: Colors.white,onPressed: (){

                  // },),
                ),
              ],
            ),
          ),
          Image.network(widget.post.image_url),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container( 
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child:Align(
            alignment: Alignment.centerLeft,
            child:Text(widget.post.likes_count.toString()+" likes",style: TextStyle(color: Colors.white), ),
 
          ),),
      
         
          Container(
            padding: EdgeInsets.only(bottom: 20, left: 20),
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: <Widget>[
                Text(
                  widget.post.username + " ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  widget.post.caption,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),


            RaisedButton(child: Text("Comments"),
            onPressed: ()async{
                await getComments(widget.post.id);

                //showComments(widget.comments);

                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => showComments(widget.comments,widget.post),
                          ),
                        );

            },)
          //showComments(widget.comments),
          //Text(widget.comments.length.toString()),


        ],
      ),
    );
  }
}
