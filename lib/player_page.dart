import 'package:flutter/material.dart';
import 'selection.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



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
      body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              color: Color(0xff18a0ff),
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
                        Text('Player Name: ',
                            style: TextStyle(
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
                        Text('Team: ',

                      style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                    ),
                        ),
                        emptyFunction(team),
                      ],
                    ),
                    SizedBox(
                      height:40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Date Signed: ',


                      style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                    ),
                        ),
                        emptyFunction(year),
                      ],
                    ),
                    SizedBox(
                      height:40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Player Position: ',),
                        emptyFunction(position),
                      ],
                    ),
                    SizedBox(
                      height:40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Player Wage: '),
                        emptyFunction(wage),
                      ],
                    ),
                    SizedBox(
                      height:40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Strong Foot: '),
                        emptyFunction(foot),
                      ],
                    ),
                    SizedBox(
                      height:40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Player Nationality: '),
                        emptyFunction(country),
                      ],
                    ),
                    SizedBox(
                      height:40,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Place of Birth: '),
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
    );
  }
  emptyFunction(var money) {
    if (money=='' || money==null){
      return Text('N/A');
    }
    else if (money!='') {
      return Text(money);
    }
  }
}
