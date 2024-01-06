

import 'package:devjobs_updated/common/login/LoginPage.dart';
import 'package:devjobs_updated/services/common/forgotservice.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}
TextEditingController _ForgotEmailController=TextEditingController();

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("RESET PASSWORD",
                style: TextStyle(
                    fontSize: 50, fontWeight: FontWeight.w500)),
          ),
          Container(
            width: 380,
            child: TextFormField(
              controller: _ForgotEmailController,
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
                  hintText: 'Enter your Email',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                ForgotService _for=ForgotService();
                try{
                  _for.ForgotPassword(_ForgotEmailController.text);
                }catch(e){
                  print(e);
                }
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return LoginPage();
              }));
              },
              child: Container(
                child: Center(
                    child: Text("R E S E T",
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
        ],
      ),
    );
  }
}
