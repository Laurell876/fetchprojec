import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'selection.dart';
import 'matchesScreen.dart';


//global variable
int idHolder = 123;

List eventNameHolder;






void main() => runApp(MaterialApp(

   routes: {
    '/': (context) => HomePage(),
     '/selection': (context) => SelectionPage(id: idHolder),
   }

));






class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> {
  Map dataList;
  List userDataList;

  allFutureFunctions(int idForPrevMatch) {

    //function to get list of previous matches, it needs the id of the team

    //tested for id number, its working
    //print(idForPrevMatch);

    Future getData(int idGetter) async {
      http.Response response = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventslast.php?id=$idGetter');
      dataList = json.decode(response.body);

      setState(() {
        userDataList = dataList['results'];
      });

      // print(userData);
      //print(userData[0]['strEvent']);

      //debugPrint(userData.toString());
      print(dataList);

    }
    getData(idForPrevMatch);
    //its working - data is being saved from function
    print(userDataList[0]['strEvent']);


  }


  Widget setImage(String url) {
    if (url != null) {
      return Container(
        height:40,
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => new CircularProgressIndicator(),

        ),
      );
    }else if (url == null){
      return Container(
        height:40,
        child: Icon(Icons.error),
      );
//        Image.asset(
//          'badge.png',
//          height: 40,
//          width:40,
//        );

    }
  }







  //selection screen function
  selectionScreen(int id, nmEvent) {
    Navigator.pushNamed(context, '/selection');
    setState(() {
      idHolder = id;
      eventNameHolder = nmEvent;
    });
  }


  final searchInput = TextEditingController();


  //getting data for list of results
  Map data;
  List userData;


  Future getData(String teamName) async {
    http.Response response = await http.get('https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$teamName');
    data = json.decode(response.body);

    setState(() {
      userData = data['teams'];
    });



    //debugPrint(userData.toString());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScoreBoard'),
        backgroundColor: Colors.tealAccent,
      ),


      body: Stack(
        children: <Widget>[
//          Container(
//            decoration: new BoxDecoration(
//              image: new DecorationImage(
//                image: new AssetImage('assets/stadium.jpg'),
//                  fit: BoxFit.cover,
//                ),
//
//              ),
//            ),


          SingleChildScrollView(

            child: Column(

              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      TextField(

                        controller: searchInput,
                        decoration: InputDecoration(
                          labelText: 'Team Name',

                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          getData(searchInput.text);
//                      setState(() {
//                        nameHolder = searchInput.text;
//                      });
                        },
                        child: Text(
                          'Search For Team',
                          style: TextStyle(
                            color: Colors.blue,
                          ),

                        ),
                      ),

                    ],

                  ),

                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: userData == null ? 0: userData.length,
                    itemBuilder: (BuildContext   context, int index) {
                      return Container(

                        child: Visibility(
                          child: GestureDetector(
                            onTap: () {

                              //selectionScreen(int.parse(userData[index]['idTeam']), userDataList[0]['strEvent']);
                              selectionScreen(int.parse(userData[index]['idTeam']), userDataList);
                            },
                            child: Card(

                              color: Colors.tealAccent,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: <Widget>[
                                    //function that sets image of avatar
                                    setImage(userData[index]['strTeamBadge']),

                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(userData[index]['strTeam']),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
