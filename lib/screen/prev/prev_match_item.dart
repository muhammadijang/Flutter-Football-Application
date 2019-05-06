import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_football/model/match_item.dart';

class PrevItem extends StatefulWidget {
  final MatchItem match;

  const PrevItem({Key key, this.match}) : super(key: key);
  
  @override
  _PrevItemState createState() => _PrevItemState(match);
}

class _PrevItemState extends State<PrevItem> {
  final MatchItem match;

  _PrevItemState(this.match);

  String teamHomeBadge = "";
  String teamAwayBadge = "";
  String dateMatch;

  // Memanggil HomeBadge
  Widget homeBadge(){
    if(teamHomeBadge.isEmpty){
      return defaultBadge();
    } else{
      return CachedNetworkImage(
        width: 30.0,
        height: 30.0,
        imageUrl: teamHomeBadge,
        // errorWidget: defaultBadge(),
        // placeholder: CircularProgressIndicator(),
      );
    }
  }

  //Badge Away Team
  Widget awayBadge(){
    if (teamAwayBadge.isEmpty) {
      return defaultBadge();
    } else {
      return CachedNetworkImage(
        width: 30.0,
        height: 30.0,
        imageUrl: teamAwayBadge,
        // placeholder: CircularProgressIndicator(),
        // errorWidget: defaultBadge(),
      );
    }
  }

  //Default Badge
  Widget defaultBadge(){
    return Icon(
      Icons.android,
      size: 30.0,
      color: Theme.of(context).primaryColor,
    );
  }

  // Pemanggilan API HomeBadge
  Future loadHomeTeam(String id) async {
    final request = await http.get("https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=$id");

    if (request.statusCode == 200) {
      List response = json.decode(request.body)['teams'];

      setState(() {
       teamHomeBadge = response[0]['strTeamBadge'];
      });
    }
  }

  // Pemanggilan API AwayBadge
  Future loadAwayTeam(String id) async {
    final request = await http.get("https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=$id");

    if (request.statusCode == 200) {
      List response = json.decode(request.body)['teams'];

      setState(() {
       teamAwayBadge = response[0]['strTeamBadge'];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    String homeId = match.homeTeamId;
    String awayId = match.awayTeamId;

    loadHomeTeam(homeId);
    loadAwayTeam(awayId);

    // localization to Indonesia Date
    initializeDateFormatting("in_ID");
    DateFormat f = DateFormat("dd MMMM yyyy", "id");
    dateMatch = f.format(DateTime.parse(match.dateMatch));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 130.0,
        child: InkWell(
          onTap: () {
            print(match.dateMatch);
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  dateMatch,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: new Container(
                        height: 100.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    homeBadge(),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(match.homeTeamName),
                                    )
                                  ],
                                ),
                                flex: 4,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    match.awayTeamScore,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                flex: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: new Text(
                        'VS',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: new Container(
                      height: 100.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  match.awayTeamScore,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  awayBadge(),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(match.awayTeamName),
                                  )
                                ],
                              ),
                              flex: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}