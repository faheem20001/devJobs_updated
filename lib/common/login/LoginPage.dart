

import 'package:devjobs_updated/common/forgotpassword/ForgotPasswordPage.dart';
import 'package:devjobs_updated/models/freelancer/user_model.dart';
import 'package:devjobs_updated/pages/admin/AdminHome.dart';
import 'package:devjobs_updated/pages/employer/HomePage.dart';
import 'package:devjobs_updated/services/common/routeservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../register/RegisterUser.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController();
 bool _obscure=true;

  final _logKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: Form(
        key: _logKey,
        child: Stack(
          children: [

            Positioned(
              top: 100,
              child: Container(
                width: 800,
                height: 800,
                child: Stack(children: [
                  Positioned(
                      left: 80,
                      top: 170,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AdminHome();
                          }));
                        },
                        child: Text("LOGIN",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w500)),
                      )),
                  Positioned(
                      top: 163,
                      left: 20,
                      child: Icon(
                        Icons.lock,
                        size: 60,
                      )
                  ),
                  Positioned(
                    left: 20,
                    top: 240,
                    child: Container(
                      width: 380,
                      child:new TextFormField(

                      textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
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

                        controller: _emailController,
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

                        validator:
                          (value){
                    if(value == null || value.isEmpty)
                    {
                    return "This cant be empty";
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
                    top: 420,
                    left: 20,
                    child: InkWell(
                      onTap: () async {
                        if (_logKey.currentState!.validate()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);

                            if (userCredential.user != null) {
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => NavigationPage(),
                              //   ),
                              //       (route) => false,
                              // );
                              RouteService rt=RouteService();
                              rt.route(context: context, userModel: UserModel(),);
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found' || e.code == 'wrong-password') {
                              // Handle invalid user or wrong password here
                              print('Invalid email or password. Please try again.');
                            } else {
                              print('Error: ${e.message}');
                            }
                          } catch (e) {
                            print('Error: $e');
                          }
                        }


                      },

                      child: Container(
                        child: Center(
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700))),
                        width: 380,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xFF81D4FA),
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                  ),
                  Positioned(
                  top: 390,
                  left: 280
                  ,child:
                  InkWell(child: Text("Forgot Password"),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ForgotPasswordPage();
                    }));
                  },)
                  ),
                  Positioned(
                    top: 500,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return RegisterUser();
                        }));
                      },
                      child: Container(
                        child: Center(
                            child: Text("Register",
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
                  Positioned(
                    top: 580,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon/g.png',
                              scale: 50,
                            ),
                            Text("Sign in with google",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        width: 380,
                        height: 60,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFF81D4FA), width: 5),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                  )
                ]),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
