import 'package:flutter/cupertino.dart';
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
import 'package:url_launcher/url_launcher.dart';






class InfoScreen extends StatefulWidget {
  InfoScreen({this.idOfTeam, this.infoSrList});
  int idOfTeam;
  Future<List<Team>> infoSrList;



  @override
  _InfoScreenState createState() => _InfoScreenState(idOfTeam: idOfTeam, infoSrList: infoSrList);
}


class _InfoScreenState extends State<InfoScreen> {
  _InfoScreenState({this.idOfTeam, this.infoSrList});

  int idOfTeam;
  Future<List<Team>> infoSrList;


  Widget setImage(String url) {
    if (url != null) {
      return Container(
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(20.0),
          child: CachedNetworkImage(

            imageUrl: url,
            placeholder: (context, url) => Container(
              height:20,
              width:20,
              child: new CircularProgressIndicator(),
            ),
          ),
        ),
      );
    } else if (url == null) {
      return Container(
        height: 20,
        child: Icon(Icons.error),
      );
//        Image.asset(
//          'badge.png',
//          height: 40,
//          width:40,
//        );

    }
  }

  Widget setImageSM(String url) {
    if (url != null) {
      return Container(
        height: 50,

        child: Image(

          image: AssetImage(url),
        ),

      );
    } else if (url == null) {
      return Container(
        height: 20,
        child: Icon(Icons.error),
      );
    }
  }


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
        child: FutureBuilder(
          future: infoSrList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
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
                  borderRadius: new BorderRadius.circular(20.0),
                  child: Container(
                    color: Color(0xff18a0ff).withOpacity(0.4),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[


                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                              ),
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(
                                      letterSpacing: 2,
                                        color: Colors.white,
                                        fontFamily: 'Bangers',
                                        fontSize: 40
                                    ),
                                  ),
                                ],

                              ),
                            ),
                            setImage(snapshot.data[index].badge),



                            SizedBox(
                              height: 40,
                            ),


                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Column(
                                children: <Widget>[

                                      stringCheckH('Alternative Name: '),
                                      SizedBox(
                                        height:10,
                                      ),
                                      stringCheck(snapshot.data[index].altName),





                                  SizedBox(
                                    height: 30,
                                  ),


                                  stringCheckH('League: '),
                                  SizedBox(
                                    height:10,
                                  ),
                                  stringCheck(snapshot.data[index].league),


                                  SizedBox(
                                    height: 30,
                                  ),


                                  stringCheckH('Country: '),
                                  SizedBox(
                                    height:10,
                                  ),
                                  stringCheck(snapshot.data[index].country),




                                  SizedBox(
                                    height: 20,
                                  ),


                                  stringCheckH('Stadium Name: '),
                                  SizedBox(
                                    height:10,
                                  ),
                                  stringCheck(snapshot.data[index].stadiumName),




                                  SizedBox(
                                    height: 40,
                                  ),
                                  setImage(snapshot.data[index].stadiumPic),
                                  SizedBox(
                                    height: 30,
                                  ),


                                  stringCheckH('Jersey'),



                                  SizedBox(
                                    height: 20,
                                  ),


                                  setImage(snapshot.data[index].jersey),


                                  SizedBox(
                                    height: 40,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Color(0xff18a0ff).withOpacity(0.6),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: () {
                                                  _launchURL(snapshot.data[index].facebook);
                                                },
                                                child: Image.asset(
                                                    'assets/icon-facebook.png',
                                                  width: 25,
                                                  height:50,
                                                )
                                            ),


                                            GestureDetector(
                                                onTap: () {
                                                  _launchURL(snapshot.data[index].instagram);
                                                },
                                                child: Image.asset(
                                                  'assets/ig.png',
                                                  width: 55,
                                                  height:50,
                                                )
                                            ),


                                            GestureDetector(
                                                onTap: () {
                                                  _launchURL(snapshot.data[index].twitter);
                                                },
                                                child: Image.asset(
                                                  'assets/twitter.png',
                                                  width: 55,
                                                  height:50,
                                                )
                                            ),



//                                    setImageSM('assets/twitter.png'),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),

                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _launchURL(String url2) async {
    String url = 'https://' + url2;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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


  stringCheckH(String s) {
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
              fontSize: 24,
              fontFamily: 'Condensed',
              color: Colors.white,

            ),
          )
        ],
      );
    }
  }

}
