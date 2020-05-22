import 'package:consultingadminapp/homepage/Contract_list.dart';
import 'package:consultingadminapp/homepage/ask_quotes.dart';
import 'package:consultingadminapp/homepage/opinion_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_container/responsive_container.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:appColor,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,size: 25.0,), onPressed: (){
          Navigator.pop(context);
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            homePageContainer(
              avatar: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("assets/legalopinion.png"),
              ),
              text: Text("opinion List".toUpperCase(),style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Gotham',
              ),),
              iconButton: IconButton(
                  icon: Icon(CupertinoIcons.forward),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Opinion_List()));
                  }),
            ),
            homePageContainer(
              avatar: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("assets/contract.png"),
              ),
              text: Text("Contract List".toUpperCase(),style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Gotham',
              ),),
              iconButton: IconButton(
                  icon: Icon(CupertinoIcons.forward),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Contract_list()));
                  }),
            ),
            homePageContainer(
              avatar: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("assets/lawsuit.png"),
              ),
              text: Text("Lawsuit".toUpperCase(),style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Gotham',
              ),),
              iconButton: IconButton(
                  icon: Icon(CupertinoIcons.forward),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Ask_quotes()));
                  }),
            ),
            sizedBoxHeight,
            sizedBoxHeight,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
        backgroundColor: appColor,
        child: Icon(Icons.add,color: Colors.white,size: 35.0,),
      ),

    );
  }
}
class homePageContainer extends StatelessWidget {
  homePageContainer({this.text,this.avatar,this.iconButton,});
  final Text text;
  final CircleAvatar avatar;
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white,
        elevation: 5.0,
        child: Padding(padding: EdgeInsets.all(8.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              avatar,
              text,
              Center(child: iconButton),
            ],
          ),
        ),
      ),
    );
  }

}

