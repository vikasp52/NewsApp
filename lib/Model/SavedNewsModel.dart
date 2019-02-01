import 'package:flutter/material.dart';

class SavedNewsModel extends StatelessWidget {

  int _NewsId;
  String _NewsTitle;
  String _NewsImageUrl;
  String _NewsUrl;

  SavedNewsModel(this._NewsTitle, this._NewsImageUrl, this._NewsUrl);

  SavedNewsModel.map(dynamic obj){
    this._NewsId = obj["NewsId"];
    this._NewsTitle = obj["NewsTitle"];
    this._NewsImageUrl = obj["NewsImageUrl"];
    this._NewsUrl = obj["NewsUrl"];

  }

  int get NewsId => _NewsId;

  String get NewsTitle => _NewsTitle;

  String get NewsImageUrl => _NewsImageUrl;

  String get NewsUrl => _NewsUrl;

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["NewsTitle"] = _NewsTitle;
    map["NewsImageUrl"] = _NewsImageUrl;
    map["NewsUrl"] = _NewsUrl;
    if(_NewsId != null){
      map["NewsId"] = _NewsId;
    }
    return map;
  }

  SavedNewsModel.fromMap(Map<String, dynamic> map){
    this._NewsId = map["NewsId"];
    this._NewsTitle = map["NewsTitle"];
    this._NewsImageUrl = map["NewsImageUrl"];
    this._NewsUrl = map["NewsUrl"];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: 'Images/LogoWithText.png',
            fit: BoxFit.fill,
            image: NewsImageUrl,
            width: double.infinity,
            height: 150.0,
          ),
          Text(_NewsTitle,textAlign: TextAlign.center, style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}


