
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false
        ,
        title: Text("Chats"),
        centerTitle: true,
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
