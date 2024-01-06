







import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../pages/employer/NewJob.dart';

class uploadJob{




  Future<dynamic> uploadJ({
    required context,
    required imageUrl,
    required uid,
    required valid,
    required jobtitle,
    required jobdesc,
    required duration,
    required deaddate,
    required postdate,

})
  async{

    final jobId=const Uuid().v4();
    User? user=FirebaseAuth.instance.currentUser;



    if(valid)
      {
        if(dateController.text=="Duration")
          {
            return showDialog(context: context, builder: (ctx)
            {

            return AlertDialog(
                title: Text("ERROR"),

              );
            }

            );

          }
        try
        {

          await FirebaseFirestore.instance.collection('jobs').doc(jobId).set({
            'jobid':jobId,
            'uploadedBy':uid,

            'email':user!.email,
            'Job Title':jobtitle,
            'Job Description':jobdesc,
            'Duration':duration,
            'userImage':imageUrl.toString(),
            'applicants':0,
            'location':'',
            'deadDate':deaddate,
            'postDate':postdate,
            'name':user!.displayName,
            'availability':true,
            'createdAt':DateTime.now().toString(),









          });
          await Fluttertoast.showToast(
              msg: "The job has been uploaded",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,
          fontSize: 18);
          jobtitleController.clear();
          jobdescController.clear();

        }
        catch(e)
    {
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("ERROR"),

        );
      });
    }finally{
          

        }

      }

  }


}