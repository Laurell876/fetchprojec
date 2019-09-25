import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';




class PlayerPage extends StatelessWidget {
  PlayerPage(this.id, this.name, this.country, this.wage, this.foot, this.position, this.pob, this.team, this.pic, this.year);
  final String id;
  final String name;
  final String position;
  final String country;
  final String wage;
  final String foot;
  final String pob;
  final String team;
  final String pic;
  final String year;


  Widget setImage(String url) {
    if (url != null) {
      return Container(
        height: 200,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(200.0),
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => new CircularProgressIndicator(),

          ),
        ),
      );
    }else if (url == null){
      return Container(
        height:20,
        child: Icon(Icons.error),
      );
//        Image.asset(
//          'badge.png',
//          height: 40,
//          width:40,
//        );

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SCOREBOARD', style: TextStyle(fontSize: 40, fontFamily: 'Vibes')),
        centerTitle: true,
        backgroundColor: Color(0xff18a0ff),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/stadium.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Color(0xff18a0ff).withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                            setImage(pic),

                        ],
                      ),

                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AutoSizeText('Player Name: ',
                              style: TextStyle(
                                color: Colors.white,
                              fontFamily: 'Nunito',
                                fontSize: 15,
                      ),
                          ),
                          emptyFunction(name),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Team: '),
                          emptyFunction(team),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Date Signed: '),
                          emptyFunction(year),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Player Position: ',),
                          emptyFunction(position),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Player Wage: '),
                          emptyFunction(wage),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Strong Foot: '),
                          emptyFunction(foot),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Player Nationality: '),
                          emptyFunction(country),
                        ],
                      ),
                      SizedBox(
                        height:40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          titleWord('Place of Birth: '),
                          emptyFunction(pob),
                        ],
                      ),
//

                    ],
                  ),
                ),
              ),
            ),

        ),
      ),
    );
  }

  titleWord(String title) {
    return AutoSizeText(title, style: TextStyle(color: Colors.white));
  }



  emptyFunction(var money) {
    if (money=='' || money==null){
      return AutoSizeText('N/A',style: TextStyle(color: Colors.white, fontSize: 15));
    }
    else if (money!='') {
      return AutoSizeText(money, style: TextStyle(color: Colors.white, fontSize: 15));
    }
  }
}
