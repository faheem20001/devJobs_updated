

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: Center(child: Text("CHATS",style: TextStyle(
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
