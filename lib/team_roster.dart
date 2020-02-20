import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'player_page.dart';
import 'search_Results.dart';
import 'frontPage.dart';
import 'package:auto_size_text/auto_size_text.dart';



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

      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/stadium.png'),
          fit: BoxFit.cover,
        ),
      ),
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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(

                  color: Color(0xff18a0ff).withOpacity(0.4),
                  child: ListView.builder(
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
                                  AutoSizeText(
                                      snapshot.data[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Bangers',
                                      fontSize: 17,
                                    ),
                                  ),
                                  AutoSizeText(
                                      snapshot.data[index].position,
                                      style: TextStyle(
                                        fontFamily: 'Bangers',
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
  stringCheck(String s) {
    if(s==null || s=='') {
      return Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Text('N/A',
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'Condensed',
              color: Colors.black,

            ),
          )
        ],
      );
    }
    else {
      return Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(s,
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'Condensed',
              color: Colors.black,

            ),
          )
        ],
      );
    }
  }


}

