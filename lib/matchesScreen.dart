import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//class MatchesScreen extends StatelessWidget {
//
//  Map data;
//  List userData;
//
//
//  Future getData(String teamName) async {
//    http.Response response = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventslast.php?id=$idOfTeam');
//    data = json.decode(response.body);
//
//    userData = data['teams'];
//    //debugPrint(userData.toString());
//  }
//
//
//
//
//  Widget setImage2(String url) {
//    if (url != null) {
//      return Container(
//        height:40,
//        child: CachedNetworkImage(
//          imageUrl: url,
//          placeholder: (context, url) => new CircularProgressIndicator(),
//        ),
//      );
//    }else if (url == null){
//      return Container(
//        height:40,
//        child: Icon(Icons.error),
//      );
//
//
//    }
//  }
//
//
//
//  MatchesScreen({this.idOfTeam});
//  final int idOfTeam;
//
//
//  @override
//  Widget build(BuildContext context) {
////    return C
//  return Column(
//    children: <Widget>[
//      //setImage2()
//
//    ],
//  );
//  }
//}







class MatchesScreen extends StatefulWidget {
  MatchesScreen({this.idOfTeam});
  int idOfTeam;


  @override
  _MatchesScreenState createState() => _MatchesScreenState(id: idOfTeam);
}

class _MatchesScreenState extends State<MatchesScreen> {
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




  _MatchesScreenState({this.id});
  int id;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


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



      setState(() {
        data2 = json.decode(response.body);
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
          Text('Past Matches', style: TextStyle(fontSize: 30),),
          SizedBox(
            height:10,
          ),
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


                      Text(userData[index]['strEvent']),
                      Text('${userData[index]['intHomeScore']} - ${userData[index]['intAwayScore']}'),
                      dateGetter(userData[index]['strDate']),
                      Divider(
                        color: Colors.tealAccent,
                      ),
                    ],
                  ),

                );
              }
          ),







          Text('Upcoming Matches', style: TextStyle(fontSize: 30),),
          SizedBox(
            height:10,
          ),
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


                      Text(userData2[index]['strEvent']),

                      dateGetter(userData2[index]['strDate']),
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
