

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/pages/admin/AdminHome.dart';
import 'package:devjobs_updated/pages/employer/HomePage.dart';
import 'package:devjobs_updated/services/freelancer/applyjobservice.dart';
import 'package:devjobs_updated/utils/widgets/comments_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../freelancer/HomePage.dart';

class Job_DetailsPage extends StatefulWidget {
  final String uploadedBy;
  final String jobid;

  Job_DetailsPage({required this.uploadedBy, required this.jobid});

  @override
  State<Job_DetailsPage> createState() => _Job_DetailsPageState();
}

class _Job_DetailsPageState extends State<Job_DetailsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;
  String? author;
  String? name;
  String? userImageUrl;
  String? jobDesc;
  String? jobTitle;
  bool? recruitment;
  String? postedDate;
  String? deadDate;
  String? location = '';
  String? email;
  int applicants = 0;
  bool isAvailable = false;
  bool showComment = false;
  String? userType;
  String? userid;
  User? user;
  String? jobid;
  String? userTypeCurrent;
  void getJobData() async {
    User? user = FirebaseAuth.instance!.currentUser;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.uploadedBy)
        .get();
    final DocumentSnapshot userDocCurrent = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();

    if (userDoc == null) {
      return;
    } else {
      setState(() {
        userType = userDoc.get('usertype');
        userTypeCurrent = userDocCurrent.get('usertype');
        author = userDoc.get('email');
        userid = userDoc.get('id');

        userImageUrl = userDoc.get('userImage');
      });
      print(userImageUrl);
    }
    final DocumentSnapshot jobDatabase = await FirebaseFirestore.instance
        .collection('jobs')
        .doc(widget.jobid)
        .get();
    if (jobDatabase == null) {
      return;
    } else {
      setState(() {
        email = jobDatabase.get('email');
        jobid = jobDatabase.get('jobid');
        jobTitle = jobDatabase.get('Job Title');
        jobDesc = jobDatabase.get('Job Description');
        deadDate = jobDatabase.get('deadDate');
        applicants = jobDatabase.get('applicants');
        isAvailable = jobDatabase.get('availability');
        location = jobDatabase.get('location');
        postedDate = jobDatabase.get('postDate');
        userImageUrl = jobDatabase.get('userImage');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getJobData();
  }

  Widget dividerWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromRGBO(130, 168, 205,1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          jobTitle == null ? "ERROR TITLE" : jobTitle!,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(userImageUrl);
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 3, color: Colors.white),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: NetworkImage(userImageUrl == null
                                          ? 'https://placehold.co/600x400.png'
                                          : userImageUrl!),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  author == null ? 'Name' : author!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    location != null
                                        ? "placeholder location"
                                        : "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 30,
                        color: Colors.white,
                        thickness: 3,
                      ),
                      Material(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                applicants.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                ''
                                'Applicants',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.how_to_reg_sharp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      FirebaseAuth.instance.currentUser!.uid !=
                              widget.uploadedBy
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  height: 20,color: Colors.white,thickness: 4,
                                ),
                                Material(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(25),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [

                                        Column(
                                          children: [

                                            Text(
                                              'Recruiment',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  User? user = _auth.currentUser;
                                                  final _uid = user!.uid;
                                                  if (_uid == widget.uploadedBy) {
                                                    try {
                                                      FirebaseFirestore.instance
                                                          .collection('jobs')
                                                          .doc(widget.jobid)
                                                          .update(
                                                              {'availability': true});
                                                    } catch (e) {
                                                      AlertDialog(
                                                        title: Text(
                                                            "The task failed successfully"),
                                                      );
                                                    }
                                                  } else {
                                                    AlertDialog(
                                                      title: Text(
                                                          "The task failed successfully 2"),
                                                    );
                                                  }
                                                  getJobData();
                                                },
                                                child: Text(
                                                  'ON',
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                )),
                                            Opacity(
                                              opacity: isAvailable == true ? 1 : 0,
                                              child: Icon(
                                                Icons.check_box,
                                                color: Colors.green,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  User? user = _auth.currentUser;
                                                  final _uid = user!.uid;
                                                  if (_uid == widget.uploadedBy) {
                                                    try {
                                                      FirebaseFirestore.instance
                                                          .collection('jobs')
                                                          .doc(widget.jobid)
                                                          .update(
                                                              {'availability': false});
                                                    } catch (e) {
                                                      AlertDialog(
                                                        title: Text(
                                                            "The task failed successfully"),
                                                      );
                                                    }
                                                  } else {
                                                    AlertDialog(
                                                      title: Text(
                                                          "The task failed successfully 2"),
                                                    );
                                                  }
                                                  getJobData();
                                                },
                                                child: Text(
                                                  'OFF',
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                )),
                                            Opacity(
                                              opacity: isAvailable == false ? 1 : 0,
                                              child: Icon(
                                                Icons.check_box,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Divider(
                        height: 30,
                        color: Colors.white,
                        thickness: 5,
                      ),
                      Material(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          children: [
                            Text(
                              'Job Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                jobDesc == null ? '' : jobDesc!,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
                right: 4,
              ),
              child: Container(
                decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(30),
                  color:Color.fromRGBO(130, 168, 205,1),
                  ),

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 10,
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              isAvailable
                                  ? "Actively Recruiting,Send CV/Resume:"
                                  : "Currently not recruiting",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,

                                color: isAvailable ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: isAvailable?MaterialButton(
                            onPressed: () {
                              applyJob aply =
                                  applyJob(email: email, jobTitle: jobTitle);
                              aply.applyforJob(email!, jobTitle);
                              aply.addApplicant(
                                  widget.jobid, applicants, context);
                              print(email);
                              print(jobTitle);
                            },
                            color: Colors.blueAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                "Easy Apply now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ):Text('Not accepting applicants currently',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Uploaded on :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            postedDate == null ? "" : postedDate!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              " Deadline Date :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            deadDate == null ? "" : deadDate!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          dividerWidget(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            AnimatedSwitcher(
                              duration: Duration(microseconds: 500),
                              child: _isCommenting
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: TextField(
                                            controller: _commentController,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            maxLength: 200,
                                            keyboardType:
                                                TextInputType.text,
                                            maxLines: 6,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(
                                                                color: Colors
                                                                    .pink))),
                                          ),
                                        ),
                                        Flexible(
                                            child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  if (_commentController
                                                          .text.length <
                                                      7) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "Comment should be longer"),
                                                            actions: [
                                                              Column(
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child:
                                                                          Text('OK'))
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  } else {
                                                    final _generatedId =
                                                        Uuid().v4();
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('jobs')
                                                        .doc(widget.jobid)
                                                        .update({
                                                      'jobcomments':
                                                          FieldValue
                                                              .arrayUnion([
                                                        {
                                                          'userid':
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                          'commentId':
                                                              _generatedId,
                                                          'name': email,
                                                          'userImageUrl':
                                                              userImageUrl,
                                                          'commentbody':
                                                              _commentController
                                                                  .text,
                                                          'time': Timestamp
                                                              .now(),
                                                        }
                                                      ])
                                                    });
                                                    await Fluttertoast.showToast(
                                                        msg:
                                                            "Your comment has been added",
                                                        toastLength: Toast
                                                            .LENGTH_LONG,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        fontSize: 18);
                                                    _commentController
                                                        .clear();
                                                  }
                                                },
                                                color: Colors.blueAccent,
                                                elevation: 0,
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                ),
                                                child: Text(
                                                  'Post',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isCommenting =
                                                        !_isCommenting;
                                                  });
                                                },
                                                child: Text('Cancel'))
                                          ],
                                        ))
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isCommenting =
                                                    !_isCommenting;
                                                showComment = false;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.comment_outlined,
                                              size: 40,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showComment = !showComment;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.arrow_drop_down_sharp,
                                              size: 40,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                            ),
                            showComment == false
                                ? Container()
                                : FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('jobs')
                                        .doc(widget.jobid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child:
                                              CircularProgressIndicator(),
                                        );
                                      } else {
                                        if (snapshot.data == null) {
                                          Center(
                                            child: Text(
                                                "No comment for this job"),
                                          );
                                        }
                                      }
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return CommentWidget(
                                              commentId:
                                                  snapshot.data!['jobcomments']
                                                      [index]['commentId'],
                                              commenterId:
                                                  snapshot.data!['jobcomments']
                                                      [index]['userid'],
                                              commenterName:
                                                  snapshot.data!['jobcomments']
                                                      [index]['name'],
                                              commentBody: snapshot
                                                      .data!['jobcomments']
                                                  [index]['commentbody'],
                                              commentImageUrl: snapshot
                                                      .data!['jobcomments']
                                                  [index]['userImageUrl']);
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 1,
                                            color: Colors.white,
                                          );
                                        },
                                        itemCount: snapshot
                                            .data!['jobcomments'].length,
                                      );
                                    },
                                  ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(130, 168, 205, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              if (userTypeCurrent == 'Freelancer') {
                return FHomePage();
              } else if (userTypeCurrent == 'Employer') {
                return HomePage();
              } else if (userTypeCurrent == 'Admin') {
                return AdminHome();
              } else {
                return Job_DetailsPage(
                  jobid: widget.jobid,
                  uploadedBy: widget.uploadedBy,
                );
              }
            }));
          },
          icon: Icon(
            Icons.close,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: Text("JOB DETAILS"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
