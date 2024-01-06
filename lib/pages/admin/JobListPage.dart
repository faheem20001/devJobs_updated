

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/utils/widgets/admin_job_widget.dart';
import 'package:flutter/material.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return AdminJobWidget(
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
        title: Text('Job List'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
