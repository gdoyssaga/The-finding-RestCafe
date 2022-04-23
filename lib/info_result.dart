// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:findingcafe_2/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findingcafe_2/favlist.dart';

class Infopage extends StatefulWidget {
  const Infopage({Key? key, required this.title, required this.docId})
      : super(key: key);
  final String? docId;
  final String title;
  @override
  State<Infopage> createState() => _InfoPageState();
}

List<String> fav_list = [];

//INFORMATION RESTAURANT
class _InfoPageState extends State<Infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('INFORMATION',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: () {
              //Push saved
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => favList()));
              //pushSaved();
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("restaurants")
            .doc(widget.docId)
            .snapshots()
            .asBroadcastStream(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var doc = snapshot.data;

          if (snapshot.hasData) {
            var phone = snapshot.data?.get("phone");
            return Card(
                child: Column(
              children: [
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(doc!.get("name"),
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 42.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown)),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: Image.network(
                      "https://cors-anywhere.herokuapp.com/" + doc.get("cover"),
                      // height: 750.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.contain),
                ),

                //SizedBox(height: 20.0),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Recommended Menu',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    child: Text(
                        doc
                            .get("recommendedMenu")
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 16.0,
                            color: Color(0xFFB4B8B9))),
                  ),
                ),

                SizedBox(height: 20.0),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.phone,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                        'Phone:  ' +
                            doc
                                .get("phone")
                                .toString()
                                .replaceAll("[", "")
                                .replaceAll("]", ""),
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber)),
                  ],
                ),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width - 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Color(0xFFF17532)),
                      child: ElevatedButton(
                          onPressed: () {
                            //SAVE
                            //print(alreadySaved);
                            //print(doc.get("name"));
                            fav_list
                                .add(doc.get("name").toString().toLowerCase());
                            setState(() {
                              // if (alreadySaved) {
                              //   // void _pushSaved(){

                              //   // }
                              // }

                              //final showName = doc.get("name");
                            });
                          },
                          child: Text(
                            'Add to Favorite',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                ),
              ],
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

//   void pushSaved() {
//     Navigator.of(context)
//         .push(MaterialPageRoute<void>(builder: (BuildContext context) {
// //         final tiles = _Saved.contains());
//       return ListTile(
//         title: Row(
//           children: [
//             SizedBox(width: 20),
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 child: Text(
//                   'showName',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 child: Text(
//                   "address",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ])
//           ],
//         ),
//       );
//     }));
//   }

}
