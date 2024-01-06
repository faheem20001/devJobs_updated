

import 'package:flutter/material.dart';

class ContractPage extends StatefulWidget {

  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}


class _ContractPageState extends State<ContractPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(

              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [

                  Container(
                    width: 380,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Search for job',
                          prefixIcon: Icon(Icons.search_rounded),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xFF81D4FA), width: 3),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: 1000,



                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(

                                child: Container(width: 200,
                                  child: Center(child: Text("Active"),),
                                  height: 40,


                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),

                              ),
                              Tab(

                                child: Container(width: 180,
                                  height: 40,
                                  child: Center(
                                    child: Text("Completed"),
                                  ),


                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(30),

                                  ),
                                ),

                              ),

                            ],


                          ),
                          Container(
                            height: 1500,
                            width: 400,
                            child: TabBarView(controller: _tabController,children: [
                              ListView.builder(
                              padding: EdgeInsets.only(bottom: 210),itemBuilder: (ctx,index){
                                return
                                  Stack(
                                    children: [
                                      Positioned(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 250,
                                            width: 500,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 30,top: 30,
                                          child: Row(
                                            children: [Icon(Icons.location_pin),Text(("India"))],
                                          )
                                      ),
                                      Positioned(
                                          left: 30,
                                          top: 65
                                          ,child: Text("CONTRACTOR NAME",style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20
                                      ),)
                                      ),
                                      Positioned(left: 40,top: 90,child: Text("Description.......................................................\n"
                                          "..........................................................................\n"
                                          "..........................................................................\n"
                                          "..........................................................................\n"
                                          "..........................................................................")),
                                      Positioned(top: 180,left: 25,child: Container(
                                        child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                          children: [Text("Fixed Price",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                          ),
                                            Text("\$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                          ],
                                        ),
                                        width: 145,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.lightBlueAccent
                                        ),
                                      )),
                                      Positioned(top: 180,right: 25,child: Container(
                                        child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                          children: [Text("Due Date",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                          ),
                                            Text("22-09-2023",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                          ],
                                        ),
                                        width: 145,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.lightBlueAccent
                                        ),
                                      )),
                                    ],
                                  );
                              },
                                itemCount: 10,),
                              ListView.builder(padding: EdgeInsets.only(bottom: 210),itemBuilder: (ctx,index){
                                return Stack(
                                  children: [
                                    Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 250,
                                          width: 500,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 30,top: 30,
                                        child: Row(
                                          children: [Icon(Icons.location_pin),Text(("India"))],
                                        )
                                    ),
                                    Positioned(
                                        left: 30,
                                        top: 65
                                        ,child: Text("CONTRACTOR NAME",style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20
                                    ),)
                                    ),
                                    Positioned(
                                        left: 25
                                        ,top: 100
                                        ,child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Icon(Icons.star),
                                                Text("Rate")
                                              ],
                                            ),
                                            width: 60,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(15)
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Icon(Icons.feedback),
                                                Text("Feedback")
                                              ],
                                            ),
                                            width: 70,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Icon(Icons.block),
                                                Text("Block")
                                              ],
                                            ),
                                            width: 60,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 70,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.lightBlueAccent,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    )
                                    ),


                                    Positioned(top: 180,left: 25,child: Container(
                                      child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                        children: [Text("Payment",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                        ),
                                          Text("Recived \$500",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                        ],
                                      ),
                                      width: 145,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18),
                                          color: Colors.lightBlueAccent
                                      ),
                                    )),
                                    Positioned(top: 180,right: 25,child: Container(
                                      child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                        children: [Text("Status",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                        ),
                                          Text("Completed",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                                        ],
                                      ),
                                      width: 145,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18),
                                          color: Colors.lightBlueAccent
                                      ),
                                    )),
                                  ],
                                );
                              },
                                itemCount: 10,),

                            ]),
                          )
                        ],
                      ),

                    ),
                  )



                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}

