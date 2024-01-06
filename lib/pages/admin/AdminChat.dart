

import 'package:flutter/material.dart';

class AdminChat extends StatefulWidget {
  const AdminChat({super.key});

  @override
  State<AdminChat> createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      title: Text('Chats'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
    ),
      body: Column(
        children: [

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
                child: ListTile(leading: CircleAvatar(child: Icon(Icons.account_circle_outlined,
                  size: 35,),),
                  title: Text('Name'),
                  subtitle: Text("Hello how are you?"),),
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
