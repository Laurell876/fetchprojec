import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


  Map data;
  List userData;








class MatchesScreen extends StatefulWidget {
  MatchesScreen({this.idOfTeam});
  int idOfTeam;


  @override
  _MatchesScreenState createState() => _MatchesScreenState(id: idOfTeam);
}

class _MatchesScreenState extends State<MatchesScreen> {
  _MatchesScreenState({this.id});
  int id;


  Widget dateGetter(String d) {
    if (d!=null) {
      return Text(d);
    }
    else if(d==null){
      return Text('Date not Available');
    }
  }




  //previous matches

  Map data;
  List userData;


  //next matches
  Map data2;
  List userData2;








  @override
  void initState() {
    // TODO: implement initState
    super.initState();


//    print(userDataList);


    Future getData(int idGetter) async {
      http.Response response = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventslast.php?id=$idGetter');

      setState(() {
        data = json.decode(response.body);
        userData = data['results'];
      });

     // print(userData);
      //print(userData[0]['strEvent']);

      //debugPrint(userData.toString());
    }

    getData(id);






    Future getData2(int idGetter) async {
      http.Response response = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventsnext.php?id=$idGetter');
      data2 = json.decode(response.body);

      setState(() {
        userData2 = data2['events'];
      });
      // print(userData);
      //print(userData[0]['strEvent']);

      //debugPrint(userData.toString());
    }

    getData2(id);

  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.all(3),child: Text('Past Matches', style: TextStyle(fontSize: 30),)),

          Divider(
            color: Colors.tealAccent,
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: userData == null ? 0: userData.length,
              itemBuilder: (BuildContext   context, int index) {
                return Container(
                  child: Column(

                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[


                          Text(userData[index]['strEvent']),
                          Text('${userData[index]['intHomeScore']} - ${userData[index]['intAwayScore']}'),
                          dateGetter(userData[index]['strDate']),

                        ],
                      ),
                      Divider(
                        color: Colors.tealAccent,
                      ),
                    ],

                  ),

                );
              }
          ),







          Container(padding: EdgeInsets.all(3),child: Text('Upcoming Matches', style: TextStyle(fontSize: 30),)),

          Divider(
            color: Colors.tealAccent,
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: userData2 == null ? 0: userData2.length,
              itemBuilder: (BuildContext   context, int index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(userData2[index]['strEvent']),

                          dateGetter(userData2[index]['strDate']),

                        ],
                      ),
                      Divider(
                        color: Colors.tealAccent,
                      ),
                    ],
                  ),

                );
              }
          ),
        ],
      ),
    );

  }
}
