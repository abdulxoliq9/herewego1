import 'package:flutter/material.dart';
import 'package:herewego1/services/dataBase_service.dart';

import '../models/post_model.dart';
import '../services/preferens.dart';
class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  static final String id = 'detail_page';
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var dateController = TextEditingController();
  var contentController = TextEditingController();

  addPost()async{
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String date = dateController.text.toString();
    String content = contentController.text.toString();
    if(firstname.isEmpty || content.isEmpty || lastname.isEmpty || date.isEmpty) return;
     var userId = await Prefs.loadUserId();
    DATAservice.addpost( Post(firstname,content,lastname,date)).then((response) => {
        responseAdd()
    });
  }

  responseAdd(){
    Navigator.of(context).pop({'data':'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: const Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              TextField(
                controller: firstnameController,
                decoration: const InputDecoration(
                  hintText: 'Firstname',
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: lastnameController,
                decoration: const InputDecoration(
                  hintText: 'Lastname',
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Content',
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Date',
                ),
              ),
              const SizedBox(height: 25,),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  color: Colors.redAccent,
                  onPressed: (){
                    addPost();
                  },
                  child: const Text('Add',style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
