import 'package:flutter/material.dart';
import 'package:herewego1/pages/detail_page.dart';
import 'package:herewego1/pages/signIn_page.dart';
import 'package:herewego1/services/auth.dart';
import 'package:herewego1/services/dataBase_service.dart';
import 'package:herewego1/services/preferens.dart';

import '../models/post_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String id = 'home_page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiGetPost();
  }

  Future onDetail()async{
    Map results = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return const DetailPage();
        }));

    if(results != null && results.containsKey('data')){
      print(results['data']);
      apiGetPost();
    }
  }
  apiGetPost()async{
    var id = await Prefs.loadUserId();
    DATAservice.getPosts(id).then((posts) => {
      responsePosts(posts)
    });
  }

  responsePosts(List<Post> posts){
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: const Text('First Fire'),
        actions: [
          IconButton(onPressed: (){
            AuthService.signOutUser(context);
          },
              icon: Icon(Icons.exit_to_app_rounded),
          color: Colors.white,)
        ],
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx,i){
            return itemOfPosts(items[i]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          onDetail();
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget itemOfPosts(Post post){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(post.lastname!,style: const TextStyle(
                color: Colors.black,fontSize: 18
              ),),
              SizedBox(width: 7,),
              Text(post.lastname!,style: const TextStyle(
                  color: Colors.black,fontSize: 18
              ),),
            ],
          ),
          const SizedBox(height: 5,),
          Text(post.date!,style: const TextStyle(
            color: Colors.black,fontSize: 14
          ),),
          SizedBox(height: 5,),
          Text(post.content!,style: const TextStyle(
            color: Colors.black,fontSize: 15
          ),),
        ],
      ),
    );
  }
}

