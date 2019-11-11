class Comment{
  
    int id;
    String text;
    DateTime created_at;
    int user_id;
    int post_id;
  

    Comment({this.id, this.text, this.created_at, this.user_id, this.post_id});


    factory Comment.fromJson(Map<String, dynamic> json){
      return Comment(id: json["id"], text: json["text"], created_at: DateTime.parse(json["created_at"]), user_id: json["user_id"], post_id: json["post_id"]);
    }
}