import 'package:flutter/material.dart';
import 'main.dart';
import'search Results.dart';



class FrontPage extends StatelessWidget {
  final searchInput = TextEditingController();

  generateSearch(String searchValue) {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xff18a0ff), Color(0xff0070bf)],
            begin:FractionalOffset.topLeft,
            end:FractionalOffset.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    'SCOREBOARD',
                  style: TextStyle(
                    fontFamily: "Bangers",
                    color: Colors.white,
                    letterSpacing: 3,
                    fontSize: 50
                  ),
                ),
                SizedBox(
                  height:100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: searchInput,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(

                      labelText: 'Search For Any Team',
                      labelStyle: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(

                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:20,
                ),

                RaisedButton(

                  color: Color(0xff18a0ff),

                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 20,
                    ),
                  ),

                  onPressed: () {
                    //generateSearch(searchInput.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>HomePage(searchString: searchInput.text))
                    );
                  },


                  shape: RoundedRectangleBorder(

//                    side: BorderSide(color:Colors.white),
//                      adds colored border
                    borderRadius: BorderRadius.circular(30.0),
                  ),

                ),


            ],
            ),
          ),
        ),
      ),
    );
}
  }