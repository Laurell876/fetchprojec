import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';






class InfoScreen extends StatefulWidget {
  InfoScreen({this.idOfTeam});
  int idOfTeam;

  @override
  _InfoScreenState createState() => _InfoScreenState(idOfTeam: idOfTeam);
}


class _InfoScreenState extends State<InfoScreen> {
  _InfoScreenState({this.idOfTeam});
  int idOfTeam;


  Widget setImage(String url) {
    if (url != null) {
      return Container(
        height:150,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(20.0),
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => new CircularProgressIndicator(),

          ),
        ),
      );
    }else if (url == null){
      return Container(
        height:20,
        child: Icon(Icons.error),
      );
//        Image.asset(
//          'badge.png',
//          height: 40,
//          width:40,
//        );

    }
  }

  Widget setImageSM(String url) {
    if (url != null) {
      return Container(
        height: 50,

          child: Image(

            image: AssetImage(url),
          ),

      );
    }else if (url == null){
      return Container(
        height:20,
        child: Icon(Icons.error),
      );
//        Image.asset(
//          'badge.png',
//          height: 40,
//          width:40,
//        );

    }
  }

  Future<List<Team>> _getTeam(int idToGenerate) async{
    var data = await http.get ('https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=$idToGenerate');
    var jsonData = json.decode(data.body);
    var listData = jsonData['teams'];
    List<Team> teams = [];

    for (var t in listData) {
      Team teamObject = Team(t['strTeamBadge'], t['strTeam'], t['strAlternate'],t['strLeague'], t['strCountry'], t['strStadium'], t['strStadiumThumb'],
          t['strTeamJersey'], t['strFacebook'], t['Twitter'], t['strInstagram']);
      teams.add(teamObject);

    }
    print(teams.length);
    return teams;

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getTeam(idOfTeam),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if(snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          snapshot.data[index].name,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                    setImage(snapshot.data[index].badge),
                    SizedBox(
                      height:40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                              Text("Alternative Name: "),
                              Text(snapshot.data[index].altName),
                            ],
                          ),
                          SizedBox(
                            height:20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("League: "),
                              Text(snapshot.data[index].league),
                            ],
                          ),
                          SizedBox(
                            height:20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Country: "),
                              Text(snapshot.data[index].country),
                            ],
                          ),
                          SizedBox(
                            height:20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Stadium Name: "),
                              Text(snapshot.data[index].stadiumName),
                            ],
                          ),


                          SizedBox(
                            height:40,
                          ),
                          setImage(snapshot.data[index].stadiumPic),
                          SizedBox(
                            height:30,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Jersey: "),
                            ],

                          ),
                          SizedBox(
                            height:20,
                          ),
                          setImage(snapshot.data[index].jersey),
                          SizedBox(
                            height:20,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.tealAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    setImageSM('assets/icon-facebook.png'),
                                    setImageSM('assets/ig.png'),
                                    setImageSM('assets/twitter.png'),
                                  ],

                                ),
                              ),
                            ),
                          ),



                        ],
                      ),

                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );

  }
}

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
