

import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: Center(child: Text("ALERTS",style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.w600
            ),),),
          ),
          Expanded(child:
          ListView.builder(itemBuilder: (ctx,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(

                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(18)
                ),
                child: ListTile(leading: CircleAvatar(child: Icon(Icons.celebration,
                  size: 25,),),
                  title: Text('Notification ${index}'),
                  subtitle: Text("Content of Notification ${index}"),),
              ),
            );
          },
            itemCount: 10,)
          )
        ],
      ),
    );
  }
}
