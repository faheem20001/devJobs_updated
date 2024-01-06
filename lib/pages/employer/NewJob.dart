
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devjobs_updated/services/employer/uploadJobService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewJobPage extends StatefulWidget {
  const NewJobPage({super.key});

  @override
  State<NewJobPage> createState() => _NewJobPageState();
}

final formKey = GlobalKey<FormState>();
final TextEditingController dateController=TextEditingController(text: "Date");
final TextEditingController priceController=TextEditingController(text: "Amount");
final TextEditingController jobtitleController=TextEditingController();
final TextEditingController companynameController=TextEditingController();
final TextEditingController jobdescController=TextEditingController();
final TextEditingController pdateController=TextEditingController();
var isValid=false;
String? imageUrl;

class _NewJobPageState extends State<NewJobPage> {
final posted=DateTime.now();
  DateTime? picked;
  Future<void> _pickedDate()async{
  picked=await showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100)
  );
  if(picked!=null)
    {
      setState(() {
        dateController.text='${picked!.year}-${picked!.month}-${picked!.day}';
        pdateController.text='${posted!.year}-${posted!.month}-${posted!.day}';

      });
    }
  }
void getData()async{


  final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

  setState(() {
    imageUrl=userDoc.get('userImage');
    //jobid=jobDoc.get('uploadedBy');


  });

}

@override
void initState() {
  super.initState();
  getData();
}
  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text("N E W  J O B"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 700,
                  width: 500,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CREATE NEW JOB",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                    ),
                    Text(
                      "Enter job details",
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 30,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: jobtitleController,
                          decoration: InputDecoration(
                              hintText: "Job Title",
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.lightBlueAccent),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 10, color: Colors.black),
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: companynameController,
                          decoration: InputDecoration(
                              hintText: "Company Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.lightBlueAccent),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: jobdescController,

                          minLines: 6,
                          maxLines: 11,
                          decoration: InputDecoration(
                              hintText: "Job Description",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.lightBlueAccent),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fixed Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 18),
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: TextFormField(
                                      controller: priceController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                    ))
                              ],
                            ),
                            width: 145,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.lightBlueAccent),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickedDate();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Duration",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                  SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: TextFormField(
                                        enabled: false,

                                        controller: dateController,
                                        decoration: InputDecoration(
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(30))),
                                      ))
                                ],
                              ),
                              width: 145,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.lightBlueAccent),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 50,
                  left: 40,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        isValid=formKey.currentState!.validate();
                        uploadJob upljob=uploadJob();
                        upljob.uploadJ(context: context,
                            imageUrl: imageUrl,
                            uid: user!.uid,
                            valid: isValid,
                            jobtitle:jobtitleController.text,
                            jobdesc:jobdescController.text,
                            duration:dateController.text,
                            deaddate:dateController.text,
                            postdate:pdateController.text
                        );
                      });

                    },
                    child: Container(
                      width: 350,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.lightBlueAccent),
                      child: Center(
                        child: Text(
                          "P O S T",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
