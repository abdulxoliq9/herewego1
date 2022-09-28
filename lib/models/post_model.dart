
class Post{

  String? firstname;
  String? lastname;
  String? date;
  String? content;

  Post(this.content,this.lastname,this.firstname, String date){
    this; date = date;
  }

  Map<String,dynamic> toJson() =>{
    'firstname' : firstname,
    'lastname' : lastname,
    'date' : date,
    'content' : content
  };

  Post.fromJson(Map<String,dynamic> json)
  : firstname = json['firstname'],
    lastname = json['lastname'],
    date = json['date'],
    content = json['content'];
}