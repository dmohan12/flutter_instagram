class Comment{
  
    int id;
    String text;
    DateTime created_at;
    int user_id;
    int post_id;
  

    Post({this.id, this.text, this.created_at, this.user_id, this.post_id});


    factory Post.fromJson(Map<String, dynamic> json){
      return Post(id: json["id"], text: json["text"], created_at: json["created_at"], user_id: json["user_id"], post_id: json["post_id"]);
    }
}