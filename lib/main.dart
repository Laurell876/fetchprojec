import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'selection.dart';
import 'matchesScreen.dart';
import 'frontPage.dart';


//global variable






void main() => runApp(MaterialApp(

   routes: {
    '/': (context) => FrontPage(),
     //'/selection': (context) => SelectionPage(id: idHolder, infoScrList: infoScreenList, infoPlList: infoRosterList, infoNMatches: infoNextMatches, infoPMatches: infoPrevMatches),
   }

));





