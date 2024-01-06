


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/pages/job/Job_Details.dart';
import 'package:devjobs_updated/services/employer/deleteJobService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobWidget extends StatefulWidget {
  final String jobId;
  final String uploadedBy;
  final String jobtitle;
  final String jobdesc;
  final String dateDuration;



  const JobWidget({
    required this.jobId,
    required this.jobtitle,
    required this.jobdesc,
    required this.dateDuration,
    required this.uploadedBy,


});



  @override
  State<JobWidget> createState() => _JobWidgetState();

}

class _JobWidgetState extends State<JobWidget> {
  String? userType;
  void getData() async
  {
    User? user=FirebaseAuth.instance!.currentUser;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uploadedBy)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        userType = userDoc.get('usertype');



      });
      print(userType);
    }

  }
  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return InkWell
      (
      onTap: ()
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          Job_DetailsPage(uploadedBy: widget.uploadedBy,jobid: widget.jobId)
        ));
      },
      onLongPress: (){
        delete_job jobserv=delete_job();
        jobserv.deletejob(context: context,uuid: widget.uploadedBy,jobid: widget.jobId,userType: userType );
      },
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                height: 250,
                width: 400,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: Color.fromRGBO(130, 168, 205,1),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          Positioned(
              left: 30,top: 30,
              child: Row(
                children: [Icon(Icons.location_pin,color: Colors.blueAccent,),Text(("India" ),style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
                )],
              )
          ),
          Positioned(
              left: 30,
              top: 65
              ,child: Text(widget.jobtitle,style: TextStyle(
          color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20
          ),)
          ),
          Positioned(left: 40,top: 90,child: Container(width: 350,child: Text(widget.jobdesc,textAlign: TextAlign.start,maxLines: 3,overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),))),
          Positioned(top: 180,left: 25,child: Container(
            child: Column(mainAxisAlignment:MainAxisAlignment.center,
              children: [Text("Fixed Price",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
              ),
                Text("\$500",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 15),)
              ],
            ),
            width: 145,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blueAccent
            ),
          )),
          Positioned(top: 180,right: 25,child: Container(
            child: Column(mainAxisAlignment:MainAxisAlignment.center,
              children: [Text("Duration",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
              ),
                Text(widget.dateDuration,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 15),)
              ],
            ),
            width: 145,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blueAccent
            ),
          )),
        ],
      ),
    );
  }
}
