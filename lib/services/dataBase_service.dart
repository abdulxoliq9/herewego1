

import 'package:firebase_database/firebase_database.dart';
import 'package:herewego1/models/post_model.dart';

class DATAservice{
  static final database = FirebaseDatabase.instance.reference();

  static Future<Stream<DatabaseEvent>> addpost(Post post)async{
    database.child('posts').push().set(post.toJson());
    return database.onChildAdded;
  }

  static Future<List<Post>> getPosts(String id)async{
    List<Post> items = [];
    Query query = database.ref.child('posts').orderByChild('userId').equalTo(id);
    var snapshot = await query.once();
    var result = snapshot.snapshot.value as Iterable;

    for(var item in result){
      items.add(Post.fromJson(Map<String,dynamic>.from(item)));
    }return items;
  }

}