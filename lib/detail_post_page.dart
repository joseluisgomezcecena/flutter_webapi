import 'package:flutter/material.dart';

class PageDetailPost extends StatefulWidget {

  List list;
  int index;

  PageDetailPost({this.list, this.index});

  @override
  _PageDetailPostState createState() => _PageDetailPostState();
}

class _PageDetailPostState extends State<PageDetailPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.list[widget.index]['post_title']}'),
        backgroundColor: Colors.redAccent,
      ),

      body: new ListView(
        children: <Widget>[
          new Image.network('http://192.168.7.193/post_api/uploads/'+widget.list[widget.index]['post_image']),
          new Container(
            padding: const EdgeInsets.all(32.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: new Text('Title: '+ widget.list[widget.index]['post_title'], style: new TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                        ),
                      ),

                      new Text('Date: '+ widget.list[widget.index]['post_date'], style: new TextStyle(
                          color: Colors.redAccent

                      ),
                      ),

                    ],
                  ),
                ),

                new Icon(Icons.star, color: Colors.redAccent,)

              ],
            ),
          ),


          new Container(
            padding: const EdgeInsets.all(32.0),
            child: new Text(widget.list[widget.index]['post_content'], softWrap: true,),
          ),


        ],
      ),
    );
  }
}
