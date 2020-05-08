import 'package:flutter/material.dart';
export 'package:gca_app/tab//pointTabIndicator.dart';
import 'package:gca_app/tab//pointTabIndicator.dart';
import 'package:gca_app/users.dart';

class Square extends StatefulWidget{
  static const String id = "/square";

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square>
  with SingleTickerProviderStateMixin {
  final tabList = ['Daily List', 'Weekly list'];
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
        title: Text('Friend Square'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicator: PointTabIndicator(
            position: PointTabIndicatorPosition.bottom,
            color: Colors.white,
            insets: EdgeInsets.only(bottom: 6),
          ),
          tabs: tabList.map((item) {
            return Tab(
              text: item,
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabList.map((item) {
          return Center(child: Text(item));
        }).toList(),
      ),
    );
  }
}
