import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'frontPage.dart';
import 'search Results.dart';





class ListOfMatches extends StatefulWidget {
  ListOfMatches({this.idOfTeam, this.infoPrMatches, this.infoNxMatches});
  int idOfTeam;

  Future<List<nextMatches>> infoNxMatches;

  Future<List<previousMatches>> infoPrMatches;


  @override
  _ListOfMatchesState createState() => _ListOfMatchesState(idOfTeam: idOfTeam, infoPrMatches: infoPrMatches, infoNxMatches: infoNxMatches);
}

class _ListOfMatchesState extends State<ListOfMatches> with AutomaticKeepAliveClientMixin<ListOfMatches>{
  _ListOfMatchesState({this.idOfTeam, this.infoPrMatches, this.infoNxMatches});
  int idOfTeam;

  Future<List<nextMatches>> infoNxMatches;

  Future<List<previousMatches>> infoPrMatches;


  //only runs init once requires : with AutomaticKeepAliveClientMixin<ListOfMatches>
  @override
  bool get wantKeepAlive => true;





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: SingleChildScrollView(
        child: Column(
              children: <Widget>[

                Container(padding: EdgeInsets.all(10),child: Text('Previous Matches')),
                Divider(
                  color: Colors.tealAccent,
                ),
                Container(
                  child: FutureBuilder(
                    future: infoPrMatches,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {



                      if(snapshot.data == null ) {
                        return Center(
                            child: Column(
                              children: <Widget>[

                                CircularProgressIndicator(),
                                Divider(
                                  color: Colors.tealAccent,
                                ),
                              ],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                 Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Row(
                                          children: <Widget>[
                                            Text(snapshot.data[index].eventPrev),

                                          ],
                                        ),
                                      ),
                                      FittedBox(
                                        child: Row(
                                          children: <Widget>[

                                            Text('${snapshot.data[index].homeScorePrev} - ${snapshot.data[index].awayScorePrev}     (home - away)'),
                                          ],
                                        ),
                                      ),




                                    ],

                                  ),

                                Text(snapshot.data[index].datePrev,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Divider(
                                  color: Colors.tealAccent,
                                ),
                              ],

                            );
                            }
                        );
                      }
                    },
                  ),
                ),

                Column(
                  children: <Widget>[
                    Container(padding: EdgeInsets.all(10),child: Text('UpComing Matches')),
                    Divider(
                      color: Colors.tealAccent,
                    ),
                    Container(
                      child: FutureBuilder(
                        future: infoNxMatches,
                        builder: (BuildContext cxt, AsyncSnapshot snap) {

                          if (snap.data == null ) {
                            return Center(child: CircularProgressIndicator(),);
                          }
                          else {
                            return ListView.builder(
                                itemCount: snap.data.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext cxt, int index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(snap.data[index].eventNext),
                                      Text(snap.data[index].dateNext,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.tealAccent,
                                      ),
                                    ],
                                  );
                            }
                            );
                          }
                        }
                      ),
                    ),
                  ],
                ),

              ],
            ),
      ),
    );


  }
}




