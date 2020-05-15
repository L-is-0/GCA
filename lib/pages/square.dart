import 'package:flutter/material.dart';
export 'package:gca_app/tab//pointTabIndicator.dart';
import 'package:gca_app/tab//pointTabIndicator.dart';
import 'file:///F:/Southampton/Y3S1/ThirdYearProject/GCA/GarbageClassificationApp/gca_app/lib/data/users.dart';
import 'package:firebase_database/firebase_database.dart';

class Square extends StatefulWidget{
  static const String id = "/square";

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square>
  with SingleTickerProviderStateMixin {
  final dbRef = FirebaseDatabase.instance.reference().child("profiles");
  final tabList = ['Daily List', 'Weekly list'];
  var lists = [];
  TabController _tabController;

  @override
  void initState() {
  _tabController = TabController(vsync: this, length: tabList.length);
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend \'s Circle'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicator: PointTabIndicator(
            position: PointTabIndicatorPosition.bottom,
            color: Colors.white,
            insets: EdgeInsets.only(bottom: 6),
          ),
          tabs: [
            Tab(icon: Icon(Icons.looks_one), text: "Daily"),
            Tab(icon: Icon(Icons.looks_two), text: "Weekly"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder(
              future: dbRef.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  lists.clear();
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Email: " + lists[index]["email"]),
                              Text("Username: "+ lists[index]["username"].toString()),
                              Text("Points: " +lists[index]["points"].toString()),
                            ],
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              }),
          FutureBuilder(
              future: dbRef.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  lists.clear();
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Email: " + lists[index]["email"]),
                              Text("Username: "+ lists[index]["username"].toString()),
                              Text("Points: " +lists[index]["points"].toString()),
                            ],
                          ),
                        );
                      });
                }
                return CircularProgressIndicator();
              })
//          _buildList(key: "key1", list: mockUsers.keys),
//          _buildList(key: "key2", list: mockUsers.keys),
        ],
      ),
    );
  }

  Widget _buildList({String key, Iterable list}) {
    return ListView.builder(
      key: PageStorageKey(key),
      itemCount: 6,
      itemBuilder: (_, i) => ListTile(title: list.map((item) => new Text(item)).toList()[i]),
    );
  }
}
