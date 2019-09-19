import 'package:flutter/material.dart';
import 'main.dart';
import 'matchesScreen.dart';


class SelectionPage extends StatefulWidget {

  SelectionPage({this.id});
  int id;

  @override
  _SelectionPageState createState() => _SelectionPageState(id: this.id);
}

class _SelectionPageState extends State<SelectionPage> {


  //this is used because value had to be defined in body
  Widget pickScreen(int sI, int idd) {
    if (sI==0) {
      return  MatchesScreen(idOfTeam: idd);
    }else if(sI!=0){
      return _widgetOptions.elementAt(_selectedIndex-1);
    }
  }


  _SelectionPageState({this.id});
  int id;





  //has to be at one because the first page is different
  int _selectedIndex = 0;


  List<Widget> _widgetOptions = <Widget>[
    //MatchesScreen(nameOfTeam: name),
    Text(
      'Index 1: Business',

    ),
    Text(
      'Index 2: School',
    ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'ScoreBoard',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
      ),
      body: pickScreen(_selectedIndex, id),



      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(const IconData(0xe900, fontFamily: 'soccerBall')),
            title: Text('Matches'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text('Team Info'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Team Roster'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[900],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        backgroundColor: Colors.tealAccent,
      ),
    );
  }
}
