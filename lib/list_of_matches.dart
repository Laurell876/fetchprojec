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

class _ListOfMatchesState extends State<ListOfMatches>{
  _ListOfMatchesState({this.idOfTeam, this.infoPrMatches, this.infoNxMatches});
  int idOfTeam;

  Future<List<nextMatches>> infoNxMatches;

  Future<List<previousMatches>> infoPrMatches;

  int index;

  List<Widget> pMatchColumnList = new List<Widget>();
  List<Widget> nMatchColumnList = new List<Widget>();







  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(

      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/stadium.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(20.0),
            child: Container(
              color: Color(0xff18a0ff).withOpacity(0.7),
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
                                fontSize: 40,
                                fontFamily: 'Bangers',
                                color: Colors.white,
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
                                //ensures it only adds the data to the widget if the list doesnt already have the data
                                if(pMatchColumnList.length<snapshot.data.length) {
                                  for(index=0;index<snapshot.data.length; index++){

                                    pMatchColumnList.add(
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[

                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),

                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                    "${snapshot.data[index].eventPrev}",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: 'Condensed',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),


                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                Text(
                                                  "${snapshot.data[index].homeScorePrev} - ${snapshot.data[index].awayScorePrev}",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontFamily: 'Condensed',
                                                    color: Colors.black,
                                                  ),
                                                ),

                                              ],

                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                Text(snapshot.data[index].datePrev,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Condensed',
                                                    color: Colors.black,
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

                                      ),
                                    );


                                  }
                                }

                                return Column(children: pMatchColumnList);

                              }
                            },
                          ),
                        ),




                            Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                child: Text(
                                  'UPCOMING MATCHES',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Bangers',
                                    color: Colors.white,
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

                                    //ensures it only adds the data to the widget if the list doesnt already have the data
                                    if(nMatchColumnList.length<snap.data.length) {
                                      for(index=0;index< snap.data.length; index++){
                                        nMatchColumnList.add(
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Wrap(
                                                direction: Axis.horizontal,
                                                children: <Widget>[
                                                  Text(
                                                    snap.data[index].eventNext,
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily: 'Condensed',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 4.0),
                                                child: Wrap(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                   Text(snap.data[index].dateNext,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: 'Condensed',
                                                        color: Colors.black,
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
                                          ),
                                        );

                                      }
                                    }

                                    return Column(children: nMatchColumnList);
                                  }
                                }
                              ),
                            ),


                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );


  }
}




