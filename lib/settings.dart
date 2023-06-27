import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/classes/languages.dart';
import 'package:task1/signUp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage1 extends StatefulWidget {
  final String fullname;
  final String id;
  final String id2;
  final String Gender;
  final String Date;
  final String address;
  final String city;
  final String region;
  final String mobile;
  final String Email;
  final String password;
  final String mainspec;
  final String subspec;
  final String scideg;
  final String filePath1;
  final List<String> list1 ;
  final List<String> list2 ;
  final List<String> list3 ;
  final String lice;
  final String video;
  final String audio;
  final String phoneNumber;
  final List<Map<String, dynamic>> dataList;
  SettingsPage1({Key? key, required this.fullname, required this.id, required this.id2, required this.Gender, required this.Date, required this.address, required this.city, required this.region, required this.mobile, required this.Email, required this.password, required this.mainspec, required this.subspec, required this.scideg, required this.filePath1, required this.lice, required this.video, required this.audio, required this.dataList,required this.list1, required this.list2, required this.list3, required this.phoneNumber,}) : super(key: key);

  @override
  State<SettingsPage1> createState() => _SettingsPage1State();
  static void setLocale(BuildContext context, Locale newLocale) {
    _SettingsPage1State? state = context.findAncestorStateOfType<_SettingsPage1State>();
    state?.setLocale(newLocale);
  }
}

class _SettingsPage1State extends State<SettingsPage1> {
  final formKey = GlobalKey<FormState>();

  bool _isDarkMode =false;
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  // void setLocale(Locale newLocale) {
  //   setState(() {
  //     SettingsPage1.setLocale(context, newLocale);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    String items1 = '';
    for (int i = 0; i < widget.list1.length; i++) {
      items1 += widget.list1[i];
      if (i < widget.list1.length - 1) {
        items1 += ' , ';
      }
    }
    String items2 = '';
    for (int i = 0; i < widget.list2.length; i++) {
      items2 += widget.list2[i];
      if (i < widget.list2.length - 1) {
        items2 += ' , ';
      }
    }
    String items3='';
    for (int i = 0; i < widget.list3.length; i++) {
      items3 += widget.list3[i];
      if (i < widget.list3.length - 1) {
        items3 += ' , ';
      }
    }
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      theme:_isDarkMode?ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[900], // Change the background color
        hintColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white), // Change the text color
          bodyText2: TextStyle(color: Colors.white),

        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: Colors.black,
          collapsedBackgroundColor: Colors.green[700],
          collapsedIconColor: Colors.white,
          textColor: Colors.white,
          collapsedTextColor: Colors.white,
        )
      ):ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
        ),
        expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.green[700],
        collapsedIconColor: Colors.white,
        textColor: Colors.white,
        collapsedTextColor: Colors.white,
      )
      ),
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            leadingWidth: 100,
            leading: Column(
              children: [
                SizedBox(height: 27,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(isDarkMode: _isDarkMode,)));
                        },
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                    Text("Back",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)
                  ],
                ),
              ],
            ),
            title: Text("Settings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 27),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(children: [
                  SizedBox(width: 17,),
                  GestureDetector(
                      onTap: (){
                        setState(() {
                        });
                      },
                      child: Text("Dark Mode",style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.w500,fontSize: 25),)),
                  SizedBox(width: 150,),
                  Switch(
                    splashRadius: 40,
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;

                      });
                    },
                  ),
                ],),
                SizedBox(height: 30,),
                Row(children: [
                  SizedBox(width: 17,),
                  Text(AppLocalizations.of(context)!.language,style: TextStyle(color: Colors.green.shade700,fontWeight: FontWeight.w500,fontSize: 25,),),
                  SizedBox(width: 20,),
                  Container(
                    width: 204,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade700,),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButton<Language>(
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.language,
                        color: Colors.green,
                      ),
                      onChanged: (Language? language) async {
                        if (language != null) {
                          // Locale _locale = await setLocale(language.languageCode as Locale);
                          // SettingsPage1.setLocale(context, _locale);
                          SettingsPage1.setLocale(context, Locale(language.languageCode,''));
                        }
                      },
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                            (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  )
                ],),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: ExpansionTile(
                        // backgroundColor: Colors.white,
                        // collapsedBackgroundColor: Colors.green[700],
                        // collapsedIconColor: Colors.white,
                        title: Row(
                          children: [
                            Icon(Icons.person,color: Colors.white,size: 40,),
                            SizedBox(width: 18,),
                            Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        children: [
                          SizedBox(height: 30,),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: ExpansionTile(
                                // backgroundColor: Colors.white,
                                // collapsedBackgroundColor: Colors.green[700],
                                // collapsedIconColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Personal info',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,right: 10),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Full name",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                              SizedBox(width: 55,),
                                              Expanded(child: Text("${widget.fullname}",style: TextStyle(fontSize: 16),)),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(children: [
                                            Text("Your ID",style:TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                            SizedBox(width: 70,),
                                            Text("${widget.id}",style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 9,),
                                            Text("${widget.id2}",style: TextStyle(fontSize: 16),),
                                          ],),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Gender",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                              SizedBox(width: 70,),
                                              Text("${widget.Gender}",style: TextStyle(fontSize: 16),),
                                            SizedBox(height: 8,),
                                         ]
                                             ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Date of Birth",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                              SizedBox(width: 40,),
                                              Text("${widget.Date}",style: TextStyle(fontSize: 16),),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(children: [
                                            Text("Personal Address",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                            SizedBox(width: 16,),
                                            Text("${widget.address}",style: TextStyle(fontSize: 16),),
                                          ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(children: [
                                            Text("City",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                            SizedBox(width: 90,),
                                            Text("${widget.city}",style: TextStyle(fontSize: 16),),
                                          ],),
                                          SizedBox(height: 8,),
                                          Row(children: [
                                            Text("Region",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                            SizedBox(width: 73,),
                                            Text("${widget.region}",style: TextStyle(fontSize: 16),),
                                          ],),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Mobile",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 70,),
                                              Text("${widget.phoneNumber}",style: TextStyle(fontSize: 16),),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Email",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 81,),
                                              Text("${widget.Email}",style: TextStyle(fontSize: 14),),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Password",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 56,),
                                              Text("${widget.password}",style: TextStyle(fontSize: 16),),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Confirm Password",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 8,),
                                              Text("${widget.password}",style: TextStyle(fontSize: 18),),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                    ]
                                  ),
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ExpansionTile(
                                // backgroundColor: Colors.white,
                                // collapsedBackgroundColor: Colors.green[700],
                                // collapsedIconColor: Colors.white,
                                title: Text(
                                  'Work info',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 3),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            Text("Main Speciality",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                            SizedBox(width: 40,),
                                            Text("${widget.mainspec}",style: TextStyle(fontSize: 16),),
                                          ],),
                                          SizedBox(height: 8,),
                                          Row(children: [
                                            Text("Sub Speciality",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                            SizedBox(width: 50,),
                                            Text("${widget.subspec}",style: TextStyle(fontSize: 16),),
                                          ],),
                                          SizedBox(height: 8,),
                                          Row(children: [
                                            Text("Scientific degree",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                            SizedBox(width: 33,),
                                            Text("${widget.scideg}",style: TextStyle(fontSize: 11),),
                                          ],),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Clinic Name",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 62,),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Clinic Address",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 49,),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Clinic phone",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 62,),
                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          GestureDetector(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 220,),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[400],
                                                      borderRadius: BorderRadius.circular(25.0),
                                                    ),
                                                    child: Icon(Icons.add,color: Colors.white,)),
                                                SizedBox(width: 4,),
                                                Text("Add",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400,color: Colors.black),)
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            child: DataTable(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.green.shade700),
                                                // borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              columnSpacing: 1.5,
                                              dataRowHeight: 30.0,
                                              columns: [
                                                DataColumn(label: Text('Clinic Name')),
                                                DataColumn(label: Text('Clinic Address')),
                                                DataColumn(label: Text('Clinic Phone')),
                                              ],
                                              rows: widget.dataList.map((result) {
                                                return DataRow(cells: [
                                                  DataCell(Text(result['clinicname'])),
                                                  DataCell(Text(result['clinicphone'])),
                                                  DataCell(Text(result['clinicAddress'])),
                                                ]);
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              Text("Upload Certificates",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 10,),
                                              GestureDetector(child: Icon(Icons.upload,size: 30,color:Colors.black,),
                                              ),
                                              SizedBox(width: 60,),
                                              Text("Upload Photo",style: TextStyle(color: Colors.green),),
                                            ],
                                          ),
                                          SizedBox(height: 3,),
                                          if (widget.filePath1 != null)
                                            Text('File link: ${widget.filePath1}',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 7,),
                                          Row(
                                            children: [
                                              Text("Upload license",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                              SizedBox(width: 37,),
                                              GestureDetector(child: Icon(Icons.upload,size: 30,color:Colors.black,),
                                              ),
                                              SizedBox(width: 60,),
                                              Text("Upload Photo",style: TextStyle(color: Colors.green),),
                                            ],
                                          ),
                                          SizedBox(height: 3,),
                                          if (widget.lice != null)
                                            Text('File link: ${widget.lice}',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 7,),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(20),
                              child: ExpansionTile(
                                // backgroundColor: Colors.white,
                                // collapsedBackgroundColor: Colors.green[700],
                                // collapsedIconColor: Colors.white,
                                title: Text(
                                  'Medical info',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,right: 10),
                                    child: Column(children: [
                                      Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                icon: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[400],
                                                      borderRadius: BorderRadius.circular(25.0),
                                                    ),
                                                    child: Icon(Icons.add,color: Colors.white,)),
                                                onPressed: () {

                                                },
                                              ),
                                              hintText: "Please add diagnosis if any",
                                            ),
                                          ),
                                        ),
                                      ],),
                                      if (widget.list1.isNotEmpty)
                                        Container(
                                          margin: EdgeInsets.all(16.0),
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade700,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            items1,
                                            style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                icon: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[400],
                                                      borderRadius: BorderRadius.circular(25.0),
                                                    ),
                                                    child: Icon(Icons.add,color: Colors.white,)),
                                                onPressed: () {}
                                              ),
                                              hintText: "Please add previous operations if any",
                                            ),
                                          ),
                                        ),

                                      ],),
                                      if (widget.list2.isNotEmpty)
                                        Container(
                                          margin: EdgeInsets.all(16.0),
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade700,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            items2,
                                            style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                icon: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[400],
                                                      borderRadius: BorderRadius.circular(25.0),
                                                    ),
                                                    child: Icon(Icons.add,color: Colors.white,)),
                                                onPressed: () {

                                                },
                                              ),
                                              hintText: "Please add medications if any",
                                            ),
                                          ),
                                        ),
                                      ],),
                                      if (widget.list3.isNotEmpty)
                                        Container(
                                          margin: EdgeInsets.all(16.0),
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade700,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            items3,
                                            style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),

                                          ),
                                        ),
                                      Row(
                                        children: [
                                          Text("Describe your condition \n             by video",style: TextStyle(fontSize: 16,)),
                                          SizedBox(width: 27,),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.upload,size: 35,)),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.videocam,size: 35,color: Colors.green[700],)),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      if (widget.video != null)
                                        Text('Video link: ${widget.video}',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                      Row(
                                        children: [
                                          Text("Describe your condition \n             by voice",style: TextStyle(fontSize: 16),),
                                          SizedBox(width: 27,),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.upload,size: 35,)),
                                          IconButton(onPressed: (){}, icon: Icon(Icons.mic,size: 35,color: Colors.green[700],)),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      if (widget.audio != null)
                                        Text('Audio link: ${widget.audio}',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 17,)
                                    ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
