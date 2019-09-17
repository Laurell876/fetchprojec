import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'selection.dart';


void main() => runApp(MaterialApp(

   routes: {
    '/': (context) => HomePage(),
     '/selection': (context) => SelectionPage(),
   }


));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String placeholderImg = 'badge.png';


  Widget setImage(String url) {
    if (url != null) {
      return CircleAvatar(
        backgroundColor: Colors.tealAccent,
        radius: 30,
        backgroundImage: NetworkImage(url),
      );
    }else if (url == null){
    return
      Image.asset(
        'badge.png',
      height: 40,
      width:40,
    );
  }
  }







  //selection screen function
  selectionScreen() {
    Navigator.pushNamed(context, '/selection');
  }


  final searchInput = TextEditingController();



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
        title: Text('Teams'),
        backgroundColor: Colors.tealAccent,
      ),


      body: SingleChildScrollView(

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
                      onTap: selectionScreen,
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
    );
  }
}
