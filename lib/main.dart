import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail_post_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: PostHome(),
    );
  }
}

class PostHome extends StatefulWidget {
  @override
  _PostHomeState createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {
  Future<List> getData() async{
    final responseData = await http.get('http://192.168.7.193/post_api/getpost.php');
    return jsonDecode(responseData.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts App'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? new ItemListPost(list: snapshot.data) : new Center(child: CircularProgressIndicator());
        },
      ),

    );
  }
}

class ItemListPost extends StatelessWidget {

  final List list;

  ItemListPost({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0: list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: (){

              Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>PageDetailPost(
                list: list,
                index: i,
              )
              )
              );

            },
            child: new Card(
              child: new ListTile(
                title: Text(list[i]['post_title'], style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
                subtitle: new Text('Date: ${list[i]['post_date']}'),
                trailing: new Image.network('http://192.168.7.193/post_api/uploads/'+list[i]['post_image'],fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              )

            ),
          ),
        );
      },
    );
  }
}
