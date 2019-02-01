import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:unfound/Model/NewsModel.dart';
import 'package:unfound/Screens/All_Topics.dart';
import 'package:unfound/Screens/DetailsNewsPage.dart';
import 'package:unfound/Screens/Widgets/commonBodyStrecture.dart';
import 'package:unfound/Util/APIUrl.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget TrendingNews(){
    return FutureBuilder<List<News>>(
      future: fatchNews(
          http.Client()), // a Future<String> or null
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? NewsList(news: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<News>> fatchNews(http.Client client) async {
    String url = Constant.base_url +
        "everything?domains=wsj.com&apiKey=" +
        Constant.key;
    final response = await client.get(url);
    return compute(parsenews, response.body);
  }

  @override
  Widget build(BuildContext context) {
    return CommonBodyStructure(
      text: "HOME",
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            width: double.infinity,
            child: Carousel(
              dotSize: 0.0,
              images: [
                NetworkImage(
                    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
                NetworkImage(
                    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'),
                NetworkImage(
                    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80')
              ],
              showIndicator: false,
              borderRadius: false,
              radius: Radius.circular(12.0),
              moveIndicatorFromBottom: 180.0,
              noRadiusForIndicator: true,
              overlayShadow: true,
              overlayShadowColors: Colors.white,
              overlayShadowSize: 0.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0,10.0,10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Trending", style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
                RaisedButton(onPressed: (){
                  Navigator.push(context, AllTopics.route());
                }, child: Text("View all", style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0
                ),),color: Colors.black,shape: StadiumBorder()),
              ],
            ),
          ),
          Expanded(child: TrendingNews()),
        ],
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<News> news;

  NewsList({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return  Card(
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
                  //hello
                ),
                //Image.network(news[index].urlToImage, height: 200.0,width: double.infinity,),
                Text(news[index].title,textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 20.0
                ),),
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
