import 'package:flutter/material.dart';
import 'package:unfound/Model/SavedNewsModel.dart';
import 'package:unfound/Screens/DetailsNewsPage.dart';
import 'package:unfound/Screens/Widgets/commonBodyStrecture.dart';
import 'package:unfound/Util/DataBaseClient.dart';

class LikedTopics extends StatefulWidget {
  @override
  _LikedTopicsState createState() => _LikedTopicsState();
}

class _LikedTopicsState extends State<LikedTopics> {
  final List<SavedNewsModel> _itemNewsList = <SavedNewsModel>[];
  Future _loading;
  var db = new DataBaseHelper();

  @override
  void initState() {
    super.initState();
    _loading = _readTodoList();
  }

  _readTodoList() async {
    List items = await db.getItems();
    items.forEach((addedItems) {
      SavedNewsModel newsItems = SavedNewsModel.fromMap(addedItems);

      setState(() {
        _itemNewsList.add(newsItems);
      });
      print("DB items: ${newsItems.NewsUrl}");
      print("DB items: ${newsItems.NewsTitle}");
    });
  }

  _deleteToDo(int id, int index) async {
    await db.deleteNewsItems(id);
    print("Deleted is $id");
    setState(() {
      _itemNewsList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBodyStructure(
      text: "SAVED TOPIC",
      child: ListView.builder(
          reverse: false,
          itemCount: _itemNewsList.length,
          itemBuilder: (_, int index) {
            return new Card(
                color: Colors.white,
                child: InkWell(
                  child: new ListTile(
                      title: _itemNewsList[index],
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Color.fromRGBO(0, 84, 179, 1.0),
                              ),
                              onPressed: () {
                                print("Delete Click");
                                _deleteToDo(_itemNewsList[index].NewsId, index);
                              })
                        ],
                      ),
                      onTap: () async{
                        var url = _itemNewsList[index].NewsUrl;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => DetailNews(url),
                            ));
                      }
                  ),
                ));
          }),
    );
  }
}
