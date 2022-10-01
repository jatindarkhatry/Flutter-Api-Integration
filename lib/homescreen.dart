

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<Photos> photoList=[];
 Future<List<Photos>> getPhotos() async {
   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
   var data= jsonDecode(response.body.toString());
   if(response.statusCode==200){
     for(Map i in data){
       Photos photos = Photos(title: i['title'], url: i['url'],id: i['id']);
       photoList.add(photos);
     }
     return photoList;
   }else{
     return photoList;
   }
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Integration'),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
              builder:(context,AsyncSnapshot<List<Photos>> snapshot) {
              return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context ,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[index].url.toString()),
                  ),
                  title:  Text('MY ID='+snapshot.data[index].id.toString()),
                  subtitle: Text(snapshot.data[index].title.toString()),
                );
              });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class Photos{
 String title, url;
 int id;
 Photos({this.title,this.url, this.id});
}