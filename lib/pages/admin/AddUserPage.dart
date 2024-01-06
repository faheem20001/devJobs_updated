

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/models/freelancer/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}
File? ProfileImage;


class _AddUserPageState extends State<AddUserPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  TextEditingController _skillController = TextEditingController();
  bool _obscure=true;
  String? ImageUrl;
  List<String> usertypes=<String>[
    "Freelancer",
    "Employer",
    "Admin"
  ];
  var selectedValue;
  final _regKey = GlobalKey<FormState>();

  void _Image_dialogue()
  {
    showDialog(context: context, builder:(context)
    {
      return AlertDialog(
        title: Center(child: Text("Choose an option")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    _getfromCamera();

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(8),
                        child: Icon(Icons.camera),),
                      Text("Camera"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    _getfromGallery();

                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(8),
                        child: Icon(Icons.image),),
                      Text("Image"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    );
  }

  void _getfromCamera()
  async{
    XFile? image=await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(image!.path);
    Navigator.pop(context);

  }

  void _getfromGallery()
  async{
    XFile? image=await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(image!.path);
    Navigator.pop(context);

  }

  void _cropImage(filePath)
  async{
    CroppedFile? croppedImage =await ImageCropper().cropImage(
        sourcePath: filePath,
        maxHeight: 1080,
        maxWidth: 1080);
    if(croppedImage!=null)
    {
      setState(() {
        ProfileImage=File(croppedImage.path);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _regKey,
        child: GestureDetector(
          onTap: (){
            _Image_dialogue();
          },
          child: Stack(
            children: [Positioned(
              child: Container(
                width: 500,
                height: 1000,
                child: Stack(children: [
                  Positioned(
                      left: 160,
                      top: 100,
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              child: ProfileImage==null ? const Icon(
                                  Icons.add_a_photo
                              ):Image.file(ProfileImage!,fit: BoxFit.fill,),
                            ),
                          )
                      )
                  ),
                  Positioned(
                    left: 20,
                    top: 250,
                    child: Container(
                      width: 380,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if(value!.isEmpty || !value.contains('@'))
                          {
                            return "Invalid Email";
                          }
                          else
                          {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 320,
                    child: Container(
                      width: 380,
                      child: TextFormField(
                        obscureText: _obscure,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value)
                        {
                          if(value!.isEmpty||value.length<7)
                          {
                            return 'Please enter valid password';
                          }
                          else
                          {
                            return null;
                          }
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _obscure=!_obscure;
                                  });
                                }
                                ,child: Icon(Icons.remove_red_eye,)),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.key),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 390,
                    child: Container(
                      width: 380,
                      child: TextFormField(
                        obscureText: _obscure,
                        controller: _cpasswordController,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _obscure=!_obscure;
                                  });
                                }
                                ,child: Icon(Icons.remove_red_eye,)),

                            hintText: 'Re-Password',
                            prefixIcon: Icon(Icons.key),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 460,
                    child: Container(
                      width: 380,
                      height: 300,
                      child: TextFormField(
                        controller: _skillController,
                        minLines: 5,
                        maxLines: 11,
                        decoration: InputDecoration(
                            hintText: 'Skills',
                            prefixIcon: Padding(
                              padding:
                              const EdgeInsets.only(bottom: 77, left: 10),
                              child: Icon(Icons.local_activity_outlined),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF81D4FA), width: 3),
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 630, left: 145, child: Row(
                    children: [
                      Text("Role:  ",style: TextStyle(
                          fontSize: 18
                      ),),
                      DropdownButton(
                        value:selectedValue,
                        items: usertypes.map<DropdownMenuItem<String>>(
                                (String value)
                            {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value));
                            }).toList(),

                        onChanged: (newvalue){
                          setState(() {
                            selectedValue=newvalue;

                          });

                        },
                      ),
                    ],
                  )
                  ),
                  Positioned(
                    top: 700,
                    left: 20,
                    child: InkWell(
                      onTap: () {
                        if(_regKey.currentState!.validate())
                        {


                          var skills = _skillController.text.split(",");

                          UserModel user = UserModel(

                            email: _emailController.text,
                            password: _passwordController.text,
                            createdAt: DateTime.now(),
                            status: 1,
                            skills: skills,
                            userType: selectedValue,
                          );

                          setState(() async{

                            try{

                              FirebaseApp tempApp = await Firebase.initializeApp(name: "flutter", options: Firebase.app().options);

                              UserCredential newUser = await FirebaseAuth.instanceFor(app: tempApp).createUserWithEmailAndPassword(email:_emailController.text , password: _passwordController.text);
                              final _uid=newUser.user!.uid;
                              final ref=FirebaseStorage.instance.ref().child('userImages').child(newUser.user!.uid+".jpg");
                              await ref.putFile(ProfileImage!);

                              ImageUrl =await ref.getDownloadURL();
                            FirebaseFirestore.instance.collection('user').doc(_uid).set({
                              'id':_uid,
                              'email':_emailController.text,
                              'userImage':ImageUrl,
                              'createdAt':DateTime.now(),
                              'usertype':selectedValue,
                              'password':_passwordController.text,
                              'skills':_skillController.text,
                              "name":user.name??"Guest",
                            });
                            Fluttertoast.showToast(
                              msg: 'User has been created',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.green,
                              fontSize: 18,
                            );
                            Navigator.pop(context);
                            }catch(e)
                            {
                              print('ERROR WRITING TO FIRESTORE$e');
                            }
                          });





                        }




                      },
                      child: Container(
                        child: Center(
                            child: Text("ADD USER",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700))),
                        width: 380,
                        height: 60,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Color(0xFF81D4FA), width: 5),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 700,
                  //   left: 20,
                  //   child: Container(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(
                  //           'assets/icon/g.png',
                  //           scale: 50,
                  //         ),
                  //         Text("Sign in with google",
                  //             style: TextStyle(
                  //                 fontSize: 20, fontWeight: FontWeight.w700)),
                  //       ],
                  //     ),
                  //     width: 380,
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //         border:
                  //             Border.all(color: Color(0xFF81D4FA), width: 5),
                  //         color: Colors.transparent,
                  //         borderRadius: BorderRadius.circular(40)),
                  //   ),
                  // )
                ]),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
