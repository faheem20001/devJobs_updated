

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/utils/widgets/job_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  String? email;
  String? imageUrl;
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
    getData();
  }
  void getData()async{
    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      email=userDoc.get('email');
      imageUrl=userDoc.get('userImage');
    });
  }
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(

              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Hey! ${email}",style: TextStyle(
                              fontSize: 25,fontWeight: FontWeight.w600
                          ),),
                        ),
                      ],
                    ),
                    Container(
                      width: 380,
                      height: 50,
                      child: TextFormField(

                        decoration: InputDecoration(
                            hintText: 'Search for job',
                            prefixIcon: Icon(Icons.search_rounded),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(30)),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(




                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabController,
                              tabs: [
                                Tab(

                                  child: Container(width: 200,
                                    child: Center(child: Text("Matches"),),
                                    height: 40,


                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),

                                ),
                                Tab(

                                  child: Container(width: 180,
                                    height: 40,
                                    child: Center(
                                      child: Text("Recent"),
                                    ),


                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                  ),

                                ),

                              ],


                            ),
                            Container(
                              height: 1500,
                              width: 400,
                              child: TabBarView(controller: _tabController,children: [
                                // ListView.builder(itemBuilder: (ctx,index){
                                //   return Stack(
                                //     children: [
                                //       Positioned(
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Container(
                                //             height: 250,
                                //             width: 500,
                                //             decoration: BoxDecoration(
                                //               color: Colors.grey,
                                //
                                //               borderRadius: BorderRadius.circular(20)
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       Positioned(
                                //       left: 30,top: 30,
                                //       child: Row(
                                //         children: [Icon(Icons.location_pin),Text(("India"))],
                                //       )
                                //       ),
                                //       Positioned(
                                //   left: 30,
                                //   top: 65
                                //   ,child: Text("TITLE OF THE JOB",style: TextStyle(
                                //         fontWeight: FontWeight.w800,
                                //         fontSize: 20
                                //       ),)
                                //       ),
                                //       Positioned(left: 40,top: 90,child: Text("Description.......................................................\n"
                                //           "..........................................................................\n"
                                //           "..........................................................................\n"
                                //           "..........................................................................\n"
                                //           "..........................................................................")),
                                //       Positioned(top: 180,left: 25,child: Container(
                                //         child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                //   children: [Text("Fixed Price",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                //   ),
                                //   Text("\$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                //   ],
                                //   ),
                                //         width: 145,
                                //         height: 60,
                                //         decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(18),
                                //           color: Colors.lightBlueAccent
                                //         ),
                                //       )),
                                //       Positioned(top: 180,right: 25,child: Container(
                                //         child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                //         children: [Text("Duration",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                //         ),
                                //         Text("1 Month",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                //         ],
                                //         ),
                                //         width: 145,
                                //         height: 60,
                                //         decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(18),
                                //             color: Colors.lightBlueAccent
                                //         ),
                                //       )),
                                //     ],
                                //   );
                                // },
                                //   itemCount: 10,),
                                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
                                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.connectionState == ConnectionState.active) {
                                      if (snapshot.data?.docs.isNotEmpty == true) {
                                        return ListView.builder(
                                        shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: NeverScrollableScrollPhysics(),

                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return JobWidget(
                                              jobId: snapshot.data!.docs[index]['jobid'],
                                              jobtitle: snapshot.data!.docs[index]['Job Title'],
                                              jobdesc: snapshot.data!.docs[index]['Job Description'],
                                              dateDuration: snapshot.data!.docs[index]['Duration'],
                                              uploadedBy: snapshot.data!.docs[index]['uploadedBy'],


                                            );
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: Text("There are no jobs"),
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
                                ListView.builder(
                                scrollDirection: Axis.vertical
                                ,
                                    physics: NeverScrollableScrollPhysics(),itemBuilder: (ctx,index){

                                  return Stack(
                                    children: [
                                      Positioned(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 250,
                                            width: 500,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 30,top: 30,
                                          child: Row(
                                            children: [Icon(Icons.location_pin),Text(("India"))],
                                          )
                                      ),
                                      Positioned(
                                          left: 30,
                                          top: 65
                                          ,child: Text("TITLE OF THE JOB",style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20
                                      ),)
                                      ),
                                      Positioned(left: 40,top: 90,child: Text("Description.......................................................\n"
                                          "..........................................................................\n"
                                          "..........................................................................\n"
                                          "..........................................................................\n"
                                          "..........................................................................")),
                                      Positioned(top: 180,left: 25,child: Container(
                                        child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                          children: [Text("Fixed Price",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                          ),
                                            Text("\$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                          ],
                                        ),
                                        width: 145,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.lightBlueAccent
                                        ),
                                      )),
                                      Positioned(top: 180,right: 25,child: Container(
                                        child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                          children: [Text("Duration",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                          ),
                                            Text("1 Month",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                          ],
                                        ),
                                        width: 145,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.lightBlueAccent
                                        ),
                                      )),
                                    ],
                                  );
                                },
                                  itemCount: 10,),

                              ]),
                            )
                          ],
                        ),

                      ),
                    )



                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
