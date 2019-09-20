import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'player_page.dart';


class TeamRoster extends StatefulWidget {
  TeamRoster({this.idOfTeam});
  int idOfTeam;


  @override
  _TeamRosterState createState() => _TeamRosterState(idOfTeam: idOfTeam);
}

class _TeamRosterState extends State<TeamRoster> {
  _TeamRosterState({this.idOfTeam});
  int idOfTeam;


  Widget setImage(String url) {
    if (url != null) {
      return Container(
        height:70,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(70.0),
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




  Future<List<Player>> _getPlayer(int idToGenerate)async {
    var data = await http.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_players.php?id=$idToGenerate');
    var jsonData = json.decode(data.body);
    var playerData = jsonData['player'];
    List<Player> players = [];

    for (var p in playerData) {
      Player playerObject = Player(p['strThumb'],p['strPlayer'], p['strPosition'],p['idPlayer'],p['strTeam'], p['strNationality'], p['dateBorn'], p['strWage'],p['strBirthlocation'], p['strSide'], p['dateSigned']);

      players.add(playerObject);
    }

    return players;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getPlayer(idOfTeam),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>PlayerPage(snapshot.data[index].playerID,
                            snapshot.data[index].name, snapshot.data[index].country, snapshot.data[index].wage,
                            snapshot.data[index].foot, snapshot.data[index].position, snapshot.data[index].pob, snapshot.data[index].team, snapshot.data[index].picture, snapshot.data[index].year)),
                      );
                    },
                    child: Card(
                      color: Colors.tealAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            setImage(snapshot.data[index].picture),
                            Text(snapshot.data[index].name),
                            Text(snapshot.data[index].position),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }


}

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
