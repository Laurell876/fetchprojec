import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'player_page.dart';
import 'search Results.dart';
import 'frontPage.dart';


class TeamRoster extends StatefulWidget {
  TeamRoster({this.idOfTeam, this.infoPList});
  int idOfTeam;
  Future<List<Player>> infoPList;


  @override
  _TeamRosterState createState() => _TeamRosterState(idOfTeam: idOfTeam, infoPList: infoPList);
}

class _TeamRosterState extends State<TeamRoster> {
  _TeamRosterState({this.idOfTeam, this.infoPList});
  int idOfTeam;
  Future<List<Player>> infoPList;


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

    }
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: infoPList,
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
                      color:  Color(0xff18a0ff),
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

