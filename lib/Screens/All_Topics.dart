import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unfound/Model/NewsModel.dart';
import 'package:unfound/Model/SavedNewsModel.dart';
import 'package:unfound/Screens/DetailsNewsPage.dart';
import 'package:http/http.dart' as http;
import 'package:unfound/Screens/Widgets/commonBodyStrecture.dart';
import 'package:unfound/Util/APIUrl.dart';
import 'package:unfound/Util/DataBaseClient.dart';

class AllTopics extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => AllTopics(),
    );
  }

  @override
  _AllTopicsState createState() => _AllTopicsState();
}

class _AllTopicsState extends State<AllTopics> {

  Widget TrendingNews() {
    return FutureBuilder<List<News>>(
      future: fatchNews(http.Client()), // a Future<String> or null
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData ? NewsList(news: snapshot.data) : Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<News>> fatchNews(http.Client client) async {
    String url = Constant.base_url + "everything?domains=wsj.com&apiKey=" + Constant.key;
    final response = await client.get(url);
    return compute(parsenews, response.body);
  }

  @override
  Widget build(BuildContext context) {
    return CommonBodyStructure(
        text: "ALL TOPICS",
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NewsSearch());
              })
        ],
        child: TrendingNews());
  }
}

class NewsSearch extends SearchDelegate<String> {
  final newsList = ["Business", "Technology", "Fineance"];
  final recentNewsList = ["Business", "Technology", "Fineance"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            close(context, null);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentNewsList : newsList;
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.description),
            title: Text(suggestionList[index]),
          );
        });
  }
}

class NewsList extends StatelessWidget {
  final List<News> news;
  var db = new DataBaseHelper();

  void _handleSave(String title, String imageUrl, String newsUrl) async {

    SavedNewsModel doItems = new SavedNewsModel(title, imageUrl, newsUrl);
    int saveItemId = await db.saveNewsItem(doItems);
    //SavedNewsModel addedItems = await db.getHubUnitItem(saveItemId);
  }


  NewsList({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5.0,
          child: ListTile(
            title: Column(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: 'Images/LogoWithText.png',
                  fit: BoxFit.fill,
                  image: news[index].urlToImage,
                  width: double.infinity,
                  height: 200.0,
                ),
                //Image.network(news[index].urlToImage, height: 200.0,width: double.infinity,),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        news[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.save),tooltip: "Save Artical", onPressed: (){
                      _handleSave(news[index].title,news[index].urlToImage,news[index].url);
                      print("Data Saved");
                    })
                  ],
                ),
              ],
            ),
            onTap: () {
              var url = news[index].url;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DetailNews(url),
                  ));
            },
          ),
        );
      },
    );
  }
}
