
import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false
        ,
        title: Text("P a y m e n t s"),
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

                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: ListTile(leading: CircleAvatar(backgroundColor: Colors.transparent,child: Icon(Icons.payments_sharp,
                  size: 40,
                color: Colors.white,
                ),),
                  title: Text('Payment Completed',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),
                  subtitle: Text("500 \$ Sent"),),
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