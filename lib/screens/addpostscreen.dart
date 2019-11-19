import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/screens/userscreens.dart';
import 'package:instagram_clone/widgets/showComment.dart';
import 'dart:io';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File _image;

  Future<void> pickImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400, maxWidth: 800);
    setState(() {});
  }

  Future<Response> upload(var token,String caption) async {

    if(caption.length>0)
    {

    FormData formData = new FormData.from(
        {"caption": caption, "image": new UploadFileInfo(_image, _image.path)});
    var response = await Dio().post(
      "https://nameless-escarpment-45560.herokuapp.com/api/v1/posts",
      data: formData,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      ),

    );
    
    return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    TextEditingController caption = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Instagram",
          style: TextStyle(fontFamily: 'Billabong', fontSize: 35),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
          padding: EdgeInsets.only(top: 200),

            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _image != null
                  ? Image.file(_image)
                  : RaisedButton(
                      child: Text("Pick Image"),
                      color: Colors.white,

                      onPressed: () {
                        pickImage();
                      },
                    ),
              TextField(
                controller: caption,
                
                decoration: InputDecoration(
                    labelText: "Caption",
                    hintText: "Enter Caption",
                  
                    prefixIcon: Icon(Icons.add_comment),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              RaisedButton(
                child: Text("Upload"),
                color: Colors.white,
                onPressed: () {
                  upload(bloc.token,caption.text);
                },
              )
            ],
          ),
          ),
          
        ],
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
