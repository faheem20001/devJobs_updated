

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/utils/widgets/job_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyJobPage extends StatefulWidget {
  const MyJobPage({Key? key});

  @override
  State<MyJobPage> createState() => _MyJobPageState();
}

class _MyJobPageState extends State<MyJobPage> {
  User? user=FirebaseAuth.instance.currentUser;
  String? imageUrl;
  String? jobid;
  String? userType;
  void initState() {

    super.initState();
    getData();
  }
  void getData()async{


    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      imageUrl=userDoc.get('userImage');
      userType = userDoc.get('usertype');
      //jobid=jobDoc.get('uploadedBy');


    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.lightBlue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(130, 168, 205,1),
        actions: [

        ],
        leadingWidth: 90,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 35,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 100,
        title: Text('MY JOBS'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body:  CustomScrollView(

        slivers: [
          SliverAppBar(
        elevation: 0,
            floating: false,
            pinned: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent

              ),



              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                ],
              ),
            ),

            backgroundColor:Colors.lightBlueAccent[50],
            toolbarHeight:0,

            centerTitle: false,

            automaticallyImplyLeading: false,



          ),

          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('jobs').where('uploadedBy', isEqualTo: user!.uid).snapshots(),
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
