import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultingadminapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../client_chat_page.dart';
import '../full_screen_image.dart';

class Contract_list extends StatefulWidget {
  @override
  _Contract_listState createState() => _Contract_listState();
}
final List<DocumentSnapshot> ContractList = [];
final databaseReference = Firestore.instance;
MediaQueryData queryData;
final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
final Color active = Colors.white;
final Color divider = Colors.white;
String myName = '';
String abtMe = '';
String myDp = '';

class _Contract_listState extends State<Contract_list> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinFo();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Center(child: Text('Contract List', style: TextStyle(color: Colors.white),),),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom:18.0),
                child: ListView.builder(
                    itemCount: ContractList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(context, index);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 15),
      child: Container(
        width: double.infinity,
        height:670,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: appColor,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 3, color: appColor),
                    image: DecorationImage(
                        image: NetworkImage(ContractList[index]['user_dp']),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(child: Text(ContractList[index]['username'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
              ],
            ),
            SizedBox(height: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: ContractList[index]['contract_document']!=null?GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                              photoUrl:  ContractList[index]['contract_document']
                            )));
                  },
                  child: Image.network(
                    ContractList[index]['contract_document'],
                    height: 250.0,
                    width: 300.0,
                  ),
                ):Image.asset('images/file.png'),
              ),
              SizedBox(height: 25,),
              Container(width: 200,height: 100,
              child: Row(
                children: <Widget>[
                  Text('Information:',style: TextStyle(fontWeight: FontWeight.bold),), SizedBox(width: 15,),
                  Flexible(child: Text( ContractList[index]['contract_information'])),
                ],
              ),

              ),
                Container(width: 200,height: 100,
                  child: Row(
                    children: <Widget>[
                      Text('Description:',style: TextStyle(fontWeight: FontWeight.bold),), SizedBox(width: 15,),
                      Flexible(child: Text( ContractList[index]['contract_description'])),
                    ],
                  ),

                ),
            ],),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)),
                          color: appColor),
                      child: FlatButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)
                        ),
                        onPressed: () {
                          deleteData(ContractList[index].documentID, index);                      },
                      ),
                    )),
                SizedBox(
                  width: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              10)),
                          color: appColor),
                      child: FlatButton(
                        child: Text(
                          "Start Chat",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => ChatScreen(
                              name: ContractList[index].data['username'],
                              photoUrl: ContractList[index].data['user_dp'],
                              receiverUid:
                              ContractList[index].data['client_uid'])));
                        },
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteData(String documentId, int index) {
    try {
      databaseReference
          .collection('contract')
          .document(documentId)
          .delete().then(
              (val) {
            setState(() {
              ContractList.removeAt(index);
            });
          });
    } catch (e) {
      print(e.toString());
    }
  }
  void getinFo() async {
    DocumentSnapshot mRef = await Firestore.instance.collection("Lawyers").document((await FirebaseAuth.instance.currentUser()).uid).get();
    setState(() {
    });
  }

  void getData() async {
    ContractList.clear();
    String uId = (await FirebaseAuth.instance.currentUser()).uid;
    databaseReference
        .collection("contract").where('lawyer_uid', isEqualTo: uId)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => ContractList.add(f));
      print('my list of data $ContractList');

      setState(() {});
    });
  }

}
