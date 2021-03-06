import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyListView extends StatefulWidget {
  MyListView({Key key}) : super(key: key);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  // @override
  // void initState(){
  //   super.initState();
  //   this._getJsonData();
  // }
  Future<List<Todos>> _getData() async {
    var res = await http.get("https://jsonplaceholder.typicode.com/todos/");
    var data = json.decode(res.body);

    print(data[0]["title"]);
    List<Todos> listingData = [];

    for (var el in data) {
      Todos todos = Todos(el["UserId"], el["id"], el["title"], el["completed"]);
      listingData.add(todos);
      // print(el);
    }
    print(listingData.length);
    return listingData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.indigoAccent[400],
          height: MediaQuery.of(context).size.height * 0.18,
          child: Center(
            child: Text(
              "HTTP Get Request",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w600
            ) ,
            )
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.white10,
            child: FutureBuilder(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null)
                  return Center(child: Text("Loading.."));

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.indigoAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data[index].title,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )
                      );
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Todos {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  Todos(this.userId, this.id, this.title, this.completed);
}
