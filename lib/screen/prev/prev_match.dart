import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_football/model/match_item.dart';
import 'package:flutter_football/screen/prev/prev_match_item.dart';

class PrevMatch extends StatefulWidget {
  @override
  _PrevMatchState createState() => _PrevMatchState();
}

class _PrevMatchState extends State<PrevMatch> {

  Future<List<PrevItem>> fetchMatch() async{
    final request = await http.get('https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=4328');

    if (request.statusCode == 200) {
      List response = json.decode(request.body)['events'];
      List<PrevItem> data = [];

      for (int i = 0; i < response.length; i++) {
        data.add(PrevItem(
          match: MatchItem(
            dateMatch: response[i]['dateEvent'],
            homeTeamName: response[i]['strHomeTeam'],
            awayTeamName: response[i]['strAwayTeam'],
            homeTeamId: response[i]['idHomeTeam'],
            awayTeamId: response[i]['idAwayTeam'],
            homeTeamScore: response[i]['intHomeScore'],
            awayTeamScore: response[i]['intAwayScore']
          ),
        ));
      }
      return data;
    } else {
      return [];
    }
  }

  Widget loadingPage(){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  Widget schedulePage(List<PrevItem> events){
    return ListView.builder(
      itemBuilder: (context, index) => events[index],
      itemCount: events.length,
    );
  }

  Widget errorPage(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Failed to Fetch Data',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            onPressed: (){
              fetchMatch();
              print('pressed');
            },
            child: Text('Try Again'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PrevItem>>(
        future: fetchMatch(),
        builder: (context, snapshot){
          print(snapshot.connectionState);
          switch(snapshot.connectionState){
            case ConnectionState.none:
                return errorPage();
              case ConnectionState.active:
                return loadingPage();
              case ConnectionState.waiting:
                return loadingPage();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  print('has data');
                  return schedulePage(snapshot.data);
                } else if (snapshot.hasError) {
                  print('has error');
                  return errorPage();
                } else {
                  return loadingPage();
                }
          }
        }
      ),
    );
  }
}