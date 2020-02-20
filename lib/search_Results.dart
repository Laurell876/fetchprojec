import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'selection.dart';
import 'matchesScreen.dart';
import 'frontPage.dart';



int idHolder = 123;

List eventNameHolder;
Future<List<Team>> infoScreenList;

Future<List<Player>> infoRosterList;
Future<List<nextMatches>> infoNextMatches;
Future<List<previousMatches>> infoPrevMatches;




class HomePage extends StatefulWidget {
  HomePage({this.searchString});
  String searchString;

  @override
  _HomePageState createState() => _HomePageState(searchString: searchString);
}




class _HomePageState extends State<HomePage> {
  _HomePageState({this.searchString});
  String searchString;


  Map dataList;
  List userDataList;


  loadEverything(int id, nmEvent) {

    //Navigator.pushNamed(context, '/selection');

      //generateSearch(searchInput.text);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>SelectionPage(id: idHolder, infoScrList: infoScreenList, infoPlList: infoRosterList, infoNMatches: infoNextMatches, infoPMatches: infoPrevMatches),)
      );


    setState(() {
      idHolder = id;
      eventNameHolder = nmEvent;
    });

    //team info screen
    Future<List<Team>> _getTeam(int idToGenerate) async{
      var data = await http.get ('https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=$idToGenerate');
      var jsonData = json.decode(data.body);
      var listData = jsonData['teams'];
      List<Team> teams = [];

      for (var t in listData) {
        Team teamObject = Team(t['strTeamBadge'], t['strTeam'], t['strAlternate'],t['strLeague'], t['strCountry'], t['strStadium'], t['strStadiumThumb'],
            t['strTeamJersey'], t['strFacebook'], t['strTwitter'], t['strInstagram']);
        teams.add(teamObject);

      }

      return teams;

    }

    setState(() {
      infoScreenList = _getTeam(idHolder);
    });



    //info for roster screen
    Future<List<Player>> _getPlayer(int idToGenerate)async {
      var data = await http.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_players.php?id=$idToGenerate');
      var jsonData = json.decode(data.body);
      var playerData = jsonData['player'];
      List<Player> players = [];

      for (var p in playerData) {
        Player playerObject = Player(p['strThumb'],p['strPlayer'], p['strPosition'],p['idPlayer'],p['strTeam'], p['strNationality'], p['dateBorn'], p['strWage'],p['strBirthlocation'], p['strSide'], p['dateSigned']);

        players.add(playerObject);
      }

      print(players.length);
      return players;
    }

    setState(() {
      infoRosterList = _getPlayer(idHolder);
    });



    //info for matches screen
    Future<List<previousMatches>> _getPrevMatches(int idGenerator) async {
      var data = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventslast.php?id=$idGenerator');
      var jsonData = json.decode(data.body);
      var prevData = jsonData['results'];

      List<previousMatches> pMatches = [];


      for (var u in prevData) {

        previousMatches prevMatch = previousMatches(u['strEvent'], u['intAwayScore'], u['intHomeScore'], u['dateEvent']);
        pMatches.add(prevMatch);
      }



      return pMatches;

    }
    setState(() {
      infoPrevMatches = _getPrevMatches(idHolder);
    });


    Future<List<nextMatches>> _getNextMatches(int idGenerator) async {
      var data = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventsnext.php?id=$idGenerator');
      var jsonData = json.decode(data.body);
      var nextData = jsonData['events'];

      List<nextMatches> nMatches = [];


      for (var u in nextData) {

        nextMatches nextMatch = nextMatches(u['strEvent'], u['dateEvent']);
        nMatches.add(nextMatch);
      }



      return nMatches;

    }
    setState(() {
      infoNextMatches = _getNextMatches(idHolder);
    });



  }


  Widget setImage(String url) {
    if (url != null) {
      return Container(
        height: 70,
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => new CircularProgressIndicator(),

        ),
      );
    }else if (url == null){
      return Container(
        height:40,
        child: Icon(Icons.error),
      );
//        Image.asset(
//          'badge.png',
//          height: 40,
//          width:40,
//        );

    }
  }










  final searchInput = TextEditingController();


  //getting data for list of results
  Map data;
  List userData;


  Future getData(String teamName) async {
    http.Response response = await http.get('https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$teamName');
    data = json.decode(response.body);

    setState(() {
      userData = data['teams'];
    });



    //debugPrint(userData.toString());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(searchString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'SCOREBOARD',
          style: TextStyle(
            fontSize: 40,
            fontFamily: "Bangers",
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff18a0ff),
      ),

      body:


      SizedBox.expand(

        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/stadium.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userData == null ? 0: userData.length,
                itemBuilder: (BuildContext   context, int index) {
                  return Container(

                    child: Visibility(
                      child: GestureDetector(
                        onTap: () {

                          //selectionScreen(int.parse(userData[index]['idTeam']), userDataList[0]['strEvent']);
                          //selectionScreen(int.parse(userData[index]['idTeam']), userDataList);
                          loadEverything(int.parse(userData[index]['idTeam']), userDataList);
                        },
                        child: Card(

                          color: Color(0xff18a0ff),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),


                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    //function that sets image of avatar
                                    setImage(userData[index]['strTeamBadge']),
                                    SizedBox(
                                      width: 40,
                                    ),
                                        Text(userData[index]['strTeam'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontFamily: 'Bangers',
                                          ),
                                        )
                                      ],

                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
      ),

    );
  }
}

//class for info team
class Team{
  final String badge;
  final String name;
  final String altName;
  final String league;
  final String country;
  //final String year;
  final String stadiumName;
  final String stadiumPic;
  final String jersey;
  final String facebook;

  final String twitter;
  final String instagram;

  Team(this.badge, this.name, this.altName, this.league, this.country,  this.stadiumName,
      this.stadiumPic, this.jersey, this.facebook, this.twitter, this.instagram);
}


//class for player roster screen

class Player {
  final String picture;
  final String name;
  final String position;
  final String playerID;



  final String team;
  final String country;
  final String dob;
  final String wage;
  final String pob;
  final String foot;
  final String year;




  Player(this.picture, this.name, this.position, this.playerID,
      this.team, this.country, this.dob, this.wage, this.pob, this.foot, this.year);
}




//classes for matches screen
class previousMatches {
  final String eventPrev;
  final String awayScorePrev;
  final String homeScorePrev;
  final String datePrev;

  previousMatches(this.eventPrev, this.awayScorePrev, this.homeScorePrev, this.datePrev);
}


class nextMatches {
  final String eventNext;
  final String dateNext;
  nextMatches(this.eventNext,  this.dateNext);
}