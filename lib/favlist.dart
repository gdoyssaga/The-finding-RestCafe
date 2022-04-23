import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'info_result.dart';
import 'searchlist_result.dart';

class favList extends StatefulWidget {
  const favList({Key? key}) : super(key: key);
  //final String query;

  @override
  favListState createState() => favListState();
}

// LIST OF FAVORITE RESTAURANT

class favListState extends State<favList> {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("restaurants");

  final _fromKey = GlobalKey<FormState>();
  //var _autoValidate = false;
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
        title: Text('SAVED FAVORITE',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //future: _userList.getuserList(query: query),
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //print(snapshot.data);
          //FETCH DATA HERE
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                var q = snapshot.data?.docs[index].get("name") ??
                    "".toString().toLowerCase();

                return fav_list.contains(q.toLowerCase())
                    ? GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Infopage(
                                title: "Info",
                                docId: snapshot.data?.docs[index].id),
                          ),
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: Image.network(
                                      "https://cors-anywhere.herokuapp.com/" +
                                          snapshot.data?.docs[index]
                                              .get("cover"),
                                      fit: BoxFit.contain,
                                    ).image)),
                                // child: Center(
                                //   child: Text(
                                //     'rger',
                                //     style: TextStyle(
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.white),
                                //     overflow: TextOverflow.clip,
                                //   ),
                                // ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        '${snapshot.data?.docs[index].get("name")}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        '${snapshot.data?.docs[index].get("address")}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      )
                    : Container();
              });
        },
      ),
    );
  }
}
