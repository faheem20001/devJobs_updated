

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class delete_job {
  Future<void> deletejob(
      {required BuildContext context,
        required uuid,
        required jobid,
        required userType}) async {
    User? user = FirebaseAuth.instance.currentUser;
    BuildContext dialogContext = context;
    final _uid = user!.uid;

    try {
      if (_uid == uuid || userType == 'Admin') {
        await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('jobs')
                        .doc(jobid)
                        .delete()
                        .then((value) {
                      Fluttertoast.showToast(
                        msg: 'Job has been deleted',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.grey,
                        fontSize: 18,
                      );
                    });

                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Text("Delete"),
                    ],
                  ),
                )
              ],
            );
          },
        );
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ERROR"),
              content: Text("You do not have permission to delete this job."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("The task failed successfully"),
            content: Text("An error occurred while deleting the job."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
