
import 'package:devjobs_updated/common/login/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class logout{
  void log_out(context)
  {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            backgroundColor: Colors.black38,
            title: Row(
              children: [
                Padding(padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.logout,
                    size: 36,

                  ),
                ),
                Padding(padding: EdgeInsets.all(8),
                  child: Text("Sign Out",
                    style:
                    TextStyle(
                        color: Colors.white,fontSize: 20
                    )
                    ,),)

              ],
            ),
            content: Text(
              "Do you want to Log Out?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
            actions: [TextButton(onPressed: (){
              Navigator.canPop(context)?Navigator.pop(context):null;
            }, child:Text("No")),
              TextButton(onPressed: (){
                _auth.signOut();
                Navigator.canPop(context)?Navigator.pop(context):null;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return LoginPage();
                }));
              }, child:Text("Yes"))],

          );
        }
    );
  }
}

