import 'package:flutter/material.dart';
import 'main.dart';
import 'matchesScreen.dart';
import 'infoScreen.dart';
import 'list_of_matches.dart';
import 'team_roster.dart';


class SelectionPage extends StatefulWidget {

  SelectionPage({this.id});
  int id;

  @override
  _SelectionPageState createState() => _SelectionPageState(id: this.id);
}

class _SelectionPageState extends State<SelectionPage> {
  _SelectionPageState({this.id});
  int id;






  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        items: [
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
//        unselectedItemColor: Colors.grey,
//        selectedItemColor: Colors.black,
        showUnselectedLabels: true,



        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[900],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        backgroundColor: Colors.tealAccent,
      ),
    );
  }


  //this is used because value had to be defined in body
  Widget pickScreen(int sI, int idd) {
    if (sI==0) {
      return  ListOfMatches(idOfTeam: idd);
    }else if (sI==1) {
      return InfoScreen(idOfTeam: idd);
    }
    else if(sI==2){
      return TeamRoster(idOfTeam: idd);
    }
  }




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



      bottomNavigationBar: bottomNavigationBar,

    );
  }
}
