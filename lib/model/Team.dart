class TeamList{
  List<Team> team;

  TeamList({this.team});

  TeamList.fromJson(Map<String, dynamic> json){
    if (json['teams'] != null){
      team = new List<Team>();
      json['teams'].forEach((v){
        team.add(new Team.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.team != null){
      data['teams'] = this.team.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  String idTeam;
  String strTeam;
  String intFormedYear;
  String strLeague;
  String strManager;
  String strStadium;
  String strStadiumDescription;
  String strStadiumLocation;
  String intStadiumCapacity;
  String strWebsite;
  String strFacebook;
  String strTwitter;
  String strInstagram;
  String strDescriptionEN;
  String teamBadge;
  String teamLogo;
  String teamBanner;

  Team(
      {this.idTeam,
      this.strTeam,
      this.intFormedYear,
      this.strLeague,
      this.strManager,
      this.strStadium,
      this.strStadiumDescription,
      this.strStadiumLocation,
      this.intStadiumCapacity,
      this.strWebsite,
      this.strFacebook,
      this.strTwitter,
      this.strInstagram,
      this.strDescriptionEN,
      this.teamBadge,
      this.teamLogo,
      this.teamBanner});

  Team.fromJson(Map<String, dynamic> json){
    idTeam = json['idTeam'];
    strTeam = json['strTeam'];
    intFormedYear = json['intFormedYear'];
    strLeague = json['strLeague'];
    strManager = json['strManager'];
    strStadium = json['strStadium'];
    strStadiumDescription = json['strStadiumDescriprion'];
    strStadiumLocation = json['strStadiumLocation'];
    intStadiumCapacity = json['intStadiumCapacity'];
    strWebsite = json['strWebsite'];
    strFacebook = json['strFacebook'];
    strTwitter = json['strTwitter'];
    strInstagram = json['strInstagram'];
    strDescriptionEN = json['strDescriptionEN'];
    teamBadge = json['teamBadge'];
    teamLogo = json['teamLogo'];
    teamBanner = json['teamBanner'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTeam'] = this.idTeam;
    data['strTeam'] = this.strTeam;
    data['intFormedYear'] = this.intFormedYear;
    data['strLeague'] = this.strLeague;
    data['strManager'] = this.strManager;
    data['strStadium'] = this.strStadium;
    data['strStadiumDescription'] = this.strStadiumDescription;
    data['strStadiumLocation'] = this.strStadiumLocation;
    data['intStadiumCapacity'] = this.intStadiumCapacity;
    data['strWebsite'] = this.strWebsite;
    data['strFacebook'] = this.strFacebook;
    data['strTwitter'] = this.strTwitter;
    data['strInstagram'] = this.strInstagram;
    data['strDesctiption'] = this.strDescriptionEN;
    data['teamBadge'] = this.teamBadge;
    data['teamLogo'] = this.teamLogo;
    data['teamBanner'] = this.teamBanner;
    return data; 
  }
}
