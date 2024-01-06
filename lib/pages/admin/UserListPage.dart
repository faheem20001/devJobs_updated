


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/utils/widgets/user_widget.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              return ListView.builder(

                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserWidget(
                    userId: snapshot.data!.docs[index]['id'],
                    email: snapshot.data!.docs[index]['email'],
                    createdAt: snapshot.data!.docs[index]['createdAt'],
                    ImageUrl:snapshot.data!.docs[index]['userImage'] ,




                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text("There are no jobs"),
                ),
              );
            }
          }
          return Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      // body: ListView.builder(itemBuilder: (context,BuildContext)
      // {
      //   return Stack(
      //     children: [
      //       Positioned(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             height: 150,
      //             width: 500,
      //             decoration: BoxDecoration(
      //                 color: Colors.grey,
      //
      //                 borderRadius: BorderRadius.circular(20)
      //             ),
      //           ),
      //         ),
      //       ),
      //
      //       Padding(
      //         padding: const EdgeInsets.all(30.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(Icons.account_circle_outlined,
      //               color: Colors.black,
      //               size: 40,),
      //             Text("User Name",style: TextStyle(
      //             fontWeight: FontWeight.w800,
      //             fontSize: 20
      //             ),),
      //           ],
      //         ),
      //       ),
      //
      //       Positioned(top: 80,left: 25,child: Container(
      //         child: Column(mainAxisAlignment:MainAxisAlignment.center,
      //           children: [Text("VIEW",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
      //           ),
      //             Text("DETAILS",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
      //           ],
      //         ),
      //         width: 145,
      //         height: 60,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(18),
      //             color: Colors.lightBlueAccent
      //         ),
      //       )),
      //       Positioned(top: 80,right: 25,child: Container(
      //         child: Column(mainAxisAlignment:MainAxisAlignment.center,
      //           children: [Text("BAN",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),
      //           ),
      //
      //           ],
      //         ),
      //         width: 145,
      //         height: 60,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(18),
      //             color: Colors.redAccent
      //         ),
      //       )),
      //     ],
      //   );
      // }
      // ),
      appBar: AppBar(
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.admin_panel_settings_rounded,
            size: 30,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 120,
        title: Text('User List'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
