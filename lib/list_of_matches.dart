import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'frontPage.dart';
import 'search Results.dart';
import 'package:auto_size_text/auto_size_text.dart';





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
        horizontal: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
              children: <Widget>[

                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    child: Text(
                        'PREVIOUS MATCHES',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito',
                      ),
                    )
                ),

                Divider(
                  color: Color(0xff18a0ff),
                  height: 10,
                  thickness: 1,
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
                                  color: Color(0xff18a0ff),
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



                                 Padding(
                                   padding: const EdgeInsets.symmetric(
                                     vertical: 2,
                                   ),
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      AutoSizeText(
                                          "${snapshot.data[index].eventPrev}",
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 15,
                                        ),
                                      ),

                                    ],

                                ),
                                 ),



                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[

                                        AutoSizeText(
                                          "${snapshot.data[index].homeScorePrev} - ${snapshot.data[index].awayScorePrev}",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                          ),
                                        ),

                                      ],

                                    ),
                                  ),


                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(snapshot.data[index].datePrev,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Nunito',
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),




                                Divider(
                                  color: Color(0xff18a0ff),
                                  height: 10,
                                  thickness: 1,
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
                    Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Text(
                          'UPCOMING MATCHES',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                          ),
                        )
                    ),



                    Divider(
                      color: Color(0xff18a0ff),
                      height: 10,
                      thickness: 1,
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          AutoSizeText(
                                              snap.data[index].eventNext,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Nunito',
                                              ),
                                          ),
                                        ],
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            AutoSizeText(snap.data[index].dateNext,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Nunito',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),



                                      Divider(
                                        color: Color(0xff18a0ff),
                                        height: 10,
                                        thickness: 1,
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




