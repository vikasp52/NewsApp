import 'package:flutter/material.dart';

class CommonBodyStructure extends StatefulWidget {
  const CommonBodyStructure({
    Key key,
    @required this.child,
    this.text,
    this.actions,
  }) : super(key: key);

  final List<Widget> actions;
  final Widget child;
  final String text;

  @override
  _CommonBodyStructureState createState() => _CommonBodyStructureState();
}

class _CommonBodyStructureState extends State<CommonBodyStructure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(0, 84, 179, 1.0),
        title: Row(
          children: <Widget>[
            Image.asset('Images/unFoundLogo.jpg', height: 30.0,),
            SizedBox(width: 10.0,),
            Text(widget.text)
          ],
        ),
        actions: widget.actions,
      ),
      //drawer: commonDrawer(),
      body: widget.child,
    );
  }
}