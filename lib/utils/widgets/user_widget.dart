


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserWidget extends StatefulWidget {
  final String userId;
  final String email;
  final Timestamp createdAt;
  final String ImageUrl;




  const UserWidget({
    required this.userId,
    required this.email,
    required this.createdAt, required this.ImageUrl,



  });



  @override
  State<UserWidget> createState() => _UserWidgetState();

}


class _UserWidgetState extends State<UserWidget> {
  String? imgUrl;
  String? jobid;
  String? email;
  String? password;
  String? uid;
  void initState() {

    super.initState();
    getData();
  }
  void getData()async{


    final DocumentSnapshot currentuserDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();
    //final DocumentSnapshot jobDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final DocumentSnapshot WidgetuserDoc=await FirebaseFirestore.instance.collection('user').doc(widget.userId).get();

    setState(() {
      //imgUrl=userDoc.get('userImage');
      //jobid=jobDoc.get('uploadedBy');
      email=WidgetuserDoc.get('email');
      password=WidgetuserDoc.get('password');
      uid=WidgetuserDoc.get('id');



    });

  }



  @override
  Widget build(BuildContext context) {
    return Stack(
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
            left:125,
            top: 130
            ,child: Text(widget.email,style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20
        ),)
        ),
        Positioned(left: 30,top: 20,child: Container(width: 350,child:
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.ImageUrl == null
                      ? 'https://placehold.co/600x400.png'
                      : widget.ImageUrl!),
                  fit: BoxFit.fill,
                )),
          ),
        ),
        )),

        Positioned(
          top: 180,
          right: 133,
          child: InkWell(
            onTap: ()
            async{
              try{
                FirebaseFirestore.instance
                    .collection('user')
                    .doc(widget.userId)
                    .delete()
                    .then((value) async{
                      User? currentUser=FirebaseAuth.instance.currentUser;
                  if(currentUser!=null && email!=null && password!=null){


                    setState(() {
                      Fluttertoast.showToast(
                        msg: 'User has been deleted',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.grey,
                        fontSize: 18,
                      );
                    });
                  }

                });
              }catch(e){
                print(e);
              }



            },
            child: Container(
            child: Column(mainAxisAlignment:MainAxisAlignment.center,
              children: [Text("B A N",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
              ),

              ],
            ),
            width: 145,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.redAccent
            ),
          ),
          ),
        ),
      ],
    );
  }
}
