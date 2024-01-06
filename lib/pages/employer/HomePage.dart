

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/common/profile/ProfilePage.dart';
import 'package:devjobs_updated/pages/employer/MyJobPage.dart';
import 'package:devjobs_updated/pages/employer/NewJob.dart';
import 'package:devjobs_updated/utils/widgets/job_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user=FirebaseAuth.instance.currentUser;
  String? imageUrl;
  String? jobid;
  void initState() {

    super.initState();
    getData();
  }
  void getData()async{


    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      imageUrl=userDoc.get('userImage');
      //jobid=jobDoc.get('uploadedBy');


    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(130, 168, 205,1),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NewJobPage();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                height: 100,
                width: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Icon(
                        Icons.add,
                        size: 60,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
        leadingWidth: 100,
        leading: Container(
          width: 200,
          height: 100,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 40,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ProfilePage(uid: user!.uid,);
                    }));
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(imageUrl == null
                              ? 'https://placehold.co/600x400.png'
                              : imageUrl!),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 146,
        title: Text(
          "DashBoard",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body:  CustomScrollView(

        slivers: [
          SliverAppBar(
        floating: false,
            pinned: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(130, 168, 205,1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
              ),

              height: 100,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return MyJobPage();
                  }));
                },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15)
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("MY",style: TextStyle(fontSize: 18,color: Colors.white)),
                            Text("JOBS",style: TextStyle(fontSize: 18,color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return NewJobPage();
                      }
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("CREATE",style: TextStyle(fontSize: 15,color: Colors.white)),
                            Text("NEW",style: TextStyle(fontSize: 15,color: Colors.white)),
                            Text("JOB",style: TextStyle(fontSize: 15,color: Colors.white),),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            backgroundColor: Colors.transparent,
            toolbarHeight: 120,

        centerTitle: false,

                automaticallyImplyLeading: false,
            expandedHeight: 10,


          ),

            SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data?.docs.isNotEmpty == true) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
            ),



        ],


      ),
    );
  }
}
