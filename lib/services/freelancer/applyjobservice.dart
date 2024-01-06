

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class applyJob{
  String? email;
  String? jobTitle;
  applyJob({required this.email,required this.jobTitle});
  Future<void> applyforJob(String email,jobTitle) async{
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
      query: "subject=Applying for $jobTitle&body=Hello, please attach Resume CV file",
    );
    final url=params.toString();
    launchUrlString(url);
  
  }
  Future<void> addApplicant(jobid,applicants,BuildContext context) async{
    var docRef=FirebaseFirestore.instance.collection('jobs').doc(jobid);
    
    docRef.update({'applicants':applicants+1});



  }
}