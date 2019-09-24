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
        height: 150,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(20.0),
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => new CircularProgressIndicator(),

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
    return Container(
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
            return ListView.builder(
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
                      child: AutoSizeText(
                        snapshot.data[index].name,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 40
                        ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AutoSizeText(
                                "Alternative Name: ",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                              AutoSizeText(snapshot.data[index].altName,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),


                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AutoSizeText("League: ",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                              AutoSizeText(snapshot.data[index].league,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AutoSizeText("Country: ",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                              AutoSizeText(snapshot.data[index].country,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              AutoSizeText("Stadium Name: ",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                              AutoSizeText(snapshot.data[index].stadiumName,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 40,
                          ),
                          setImage(snapshot.data[index].stadiumPic),
                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText("Jersey: ",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                ),
                              ),
                            ],

                          ),


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
                              color: Color(0xff18a0ff),
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



                                    setImageSM('assets/twitter.png'),
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
            );
          }
        },
      ),
    );
  }

  _launchURL(String url2) async {
    String url = url2;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
