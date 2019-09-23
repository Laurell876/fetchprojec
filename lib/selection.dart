import 'package:flutter/material.dart';
import 'main.dart';
import 'matchesScreen.dart';
import 'infoScreen.dart';
import 'list_of_matches.dart';
import 'team_roster.dart';
import 'frontPage.dart';
import 'search Results.dart';


class SelectionPage extends StatefulWidget {

  SelectionPage({this.id, this.infoScrList, this.infoPlList, this.infoPMatches, this.infoNMatches});
  int id;
  Future<List<Team>> infoScrList;
  Future<List<Player>> infoPlList;

  Future<List<nextMatches>> infoNMatches;

  Future<List<previousMatches>> infoPMatches;

  @override
  _SelectionPageState createState() => _SelectionPageState(id: this.id, infoScrList: infoScrList, infoPlList: infoPlList, infoNMatches: infoNMatches, infoPMatches: infoPMatches);
}

class _SelectionPageState extends State<SelectionPage> {
  _SelectionPageState({this.id, this.infoScrList, this.infoPlList, this.infoPMatches, this.infoNMatches});
  int id;
  Future<List<Team>> infoScrList;
  Future<List<Player>> infoPlList;

  Future<List<nextMatches>> infoNMatches;

  Future<List<previousMatches>> infoPMatches;




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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Color(0xff18a0ff),
      ),
    );
  }


  //this is used because value had to be defined in body
  Widget pickScreen(int sI, int idd) {
    if (sI==0) {
      return  ListOfMatches(idOfTeam: idd, infoPrMatches: infoPMatches, infoNxMatches: infoNMatches);
    }else if (sI==1) {
      return InfoScreen(idOfTeam: idd, infoSrList: infoScrList);
    }
    else if(sI==2){
      return TeamRoster(idOfTeam: idd, infoPList: infoPlList);
    }
  }




  //has to be at one because the first page is different
  int _selectedIndex = 0;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('hi');
    print(infoScrList);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'SCOREBOARD',

          style: TextStyle(
            fontFamily: 'Vibes',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff18a0ff),
        centerTitle: true,
      ),
      body: pickScreen(_selectedIndex, id),



      bottomNavigationBar: bottomNavigationBar,

    );
  }
}



