import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';




class ListOfMatches extends StatefulWidget {
  ListOfMatches({this.idOfTeam});
  int idOfTeam;


  @override
  _ListOfMatchesState createState() => _ListOfMatchesState(idOfTeam: idOfTeam);
}

class _ListOfMatchesState extends State<ListOfMatches> with AutomaticKeepAliveClientMixin<ListOfMatches>{
  _ListOfMatchesState({this.idOfTeam});
  int idOfTeam;

  //only runs init once requires : with AutomaticKeepAliveClientMixin<ListOfMatches>
  @override
  bool get wantKeepAlive => true;


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


  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[

            Container(padding: EdgeInsets.all(10),child: Text('Previous Matches')),
            Divider(
              color: Colors.tealAccent,
            ),
            Container(
              child: FutureBuilder(
                future: _getPrevMatches(idOfTeam),
                builder: (BuildContext context, AsyncSnapshot snapshot) {



                  if(snapshot.data == null ) {
                    return Center(
                        child: Column(
                          children: <Widget>[

                            Text('Loading...'),
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
                                Text(snapshot.data[index].eventPrev),
                                Text('${snapshot.data[index].homeScorePrev} - ${snapshot.data[index].awayScorePrev}     (home - away)'),
                              ],

                            ),
                            Text(snapshot.data[index].datePrev),
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
                    future: _getNextMatches(idOfTeam),
                    builder: (BuildContext cxt, AsyncSnapshot snap) {

                      if (snap.data == null ) {
                        return Center(child: Text('Loading...'));
                      }
                      else {
                        return ListView.builder(
                            itemCount: snap.data.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext cxt, int indx) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snap.data[indx].eventNext),
                                  Text(snap.data[indx].dateNext),
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
        );


  }
}




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