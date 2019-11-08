import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/screens/loadingscreen.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class ShowPost extends StatefulWidget {
  Post post;

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

  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

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
                  child: Text(
                    widget.post.username,
                    style: TextStyle(color: Colors.white),
                  ),
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
          Text(widget.post.likes_count.toString()),
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
        ],
      ),
    );
  }
}
