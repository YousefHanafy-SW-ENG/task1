import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/curve.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        Row(
          children: [
            Stack(
              children: [
                Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(180),
                bottomLeft: Radius.circular(10)
                         ),
                 color: Colors.cyan[800],
                     ),
                  height: 300.0,
    width: 270,
    child: Column(
                children: [
                  SizedBox(height: 100,),
                  Text(
                  'Hello, world!',
                  style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  ),
                  ),
                ],
    ),
    ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(180),
                        bottomLeft: Radius.circular(20)
                    ),
                    color: Colors.cyan[400],
                  ),
                  height: 280.0,
                  width: 250,
                  child: Column(
                    children: [
                      SizedBox(height: 150,),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            'assets/Group 1205.png',
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10,),
            Column(
              children: [
                SizedBox(height: 90,),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/gamed.png'),
                    radius: 24,
                  ),
                ),
                Text("Yousef"),
              ],
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width: 40,),
          Container(
            width: 130,
            height: 140,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white,),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Image.asset('assets/Path 763.png',),
                SizedBox(height: 5,),
                Text("Dashboard",style: TextStyle(fontSize: 15),),
              ],
            ),
          ),
          SizedBox(width: 20,),
          Container(
            width: 130,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white,),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Image.asset('assets/Path 425.png',),
                SizedBox(height: 5,),
                Text("         Clinical & \n Non-clinical Risks",style: TextStyle(fontSize: 15),),
              ],
            ),
          ),
        ],),
            SizedBox(height: 15,),
            Row(children: [
              SizedBox(width: 40,),
              Container(
                width: 130,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Image.asset('assets/Delete-Shield-11304.png',),
                    SizedBox(height: 10,),
                    Text("OVR",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Container(
                width: 130,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Image.asset('assets/Group 1322.png',),
                    SizedBox(height: 8,),
                    Text("Staff Risk",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ],),
            SizedBox(height: 15,),
            Row(children: [
              SizedBox(width: 40,),
              Container(
                width: 130,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Image.asset('assets/Group 1960.png',),
                    SizedBox(height: 9,),
                    Text("PCRA & ICRA",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Container(
                width: 130,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Image.asset('assets/Bar-Chart-12818.png',),
                    SizedBox(height: 9,),
                    Text("KPIS",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ],),
            SizedBox(height: 60,)
          ],
        ),
      ),
          bottomNavigationBar: SizedBox(
            height: 90,
            child: ClipRRect(
            borderRadius: BorderRadius.vertical(
               top: Radius.circular(30),
            ),
                child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,color: Colors.white,),
                      label: 'Home'
                  ),
                  BottomNavigationBarItem(icon: Icon(Icons.settings,size: 30,color: Colors.white,),
                      label: 'Settings'
                  ),
                ],
                  backgroundColor: Colors.cyan,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  selectedLabelStyle: TextStyle(fontSize: 16,color: Colors.white),
                  unselectedLabelStyle: TextStyle(fontSize: 16,color: Colors.white),
              ),
            ),
          )
    );
  }
}
