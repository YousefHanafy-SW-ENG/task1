import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:record/record.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task1/myButton.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task1/settings.dart';
import 'package:task1/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';
class SignUp extends StatefulWidget {
  final bool isDarkMode ;

  const SignUp({Key? key,required this.isDarkMode}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording=false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final clinicNameController = TextEditingController();
  final clinicPhoneController = TextEditingController();
  final clinicAddressController = TextEditingController();
  final diagnosisController = TextEditingController();
  final operationsController = TextEditingController();
  final medicationsController = TextEditingController();
  final dateController = TextEditingController();
  final idController = TextEditingController();
  String items11 = '';
  String items22 = '';
  String items33 = '';
  String dropdownValue1 = 'id';
  String dropdownValue2 = 'Cairo';
  String dropdownValue3 = 'Tagamo3';
  String dropdownValue4 = 'Cardiology';
  String dropdownValue5 = 'Cardiology';
  String dropdownValue6 = 'Master of Clinical Medicine';
  String radioButtonItem = 'Male';
  late String phoneNumber;
  int id = 1;
  final List<String> list1 = [];
  final List<String> list2 = [];
  final List<String> list3 = [];
  File? _videoFile;
  File? _voiceRecordFile;
  File? _file;
  DateTime? selectedDate;
  final _dbPath = 'my_database.db';
  late Database _database;
  String filePath1='';
  String filePath2='';
  String videoPath='';
  String audioPath='';

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    super.initState();
  }
  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
  Future<void>StartRecording()async{
    try{
      if(await audioRecord.hasPermission())
        {
          await audioRecord.start();
          setState(() {
            isRecording=true;
          });
        }
    }
        catch(e){
      print("Error Start Recording: $e");
        }
  }
  Future<void>stopRecording()async{
    try{
      String? path = await audioRecord.stop();
      setState(() {
        isRecording=false;
        audioPath=path!;
      });
    }
    catch(e){
      print("Error Stopping Record: $e");
    }
  }
  Future<void>playRecording()async{
    try{
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    }
    catch(e){
      print("Error playing Recording: $e");
    }
  }

  void _addItemToList1(String item) {
    setState(() {
      list1.add(item);
      diagnosisController.clear();
    });
  }
  void _addItemToList2(String item) {
    setState(() {
      list2.add(item);
      operationsController.clear();
    });
  }
  void _addItemToList3(String item) {
    setState(() {
      list3.add(item);
      medicationsController.clear();
    });
  }

  void _openFilePicker() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath1 = result.files.single.path!;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File Uploaded Succesfulyy'),
            )
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload file agian'),
          )
      );
    }
  }
  void _openFilePicker2() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath2 = result.files.single.path!;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File Uploaded Succesfulyy'),
            )
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload file agian'),
          )
      );
    }
  }
  void _openvideoPicker() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        videoPath = result.files.single.path!;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Vidoe Uploaded Succesfulyy'),
            )
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload Video agian'),
          )
      );
    }
  }
  void _openaudioPicker() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        audioPath = result.files.single.path!;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('audio Uploaded Succesfulyy'),
            )
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload audio agian'),
          )
      );
    }
  }
  void _openphotoPicker() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath1 = result.files.single.path!;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('photo Uploaded Succesfulyy'),
            )
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload photo agian'),
          )
      );
    }
  }
  List<Map<String, dynamic>> _results = [];
  void _addResults() {
    String clinicname = clinicNameController.text;
    String clinicAddress = clinicPhoneController.text;
    String clinicPhone = clinicAddressController.text;

    if (clinicname.isNotEmpty && clinicAddress.isNotEmpty && clinicPhone.isNotEmpty) {
      setState(() {
        _results.add({
          'clinicname': clinicname,
          'clinicAddress': clinicAddress,
          'clinicphone': clinicPhone,
        });
        clinicNameController.clear();
        clinicAddressController.clear();
        clinicPhoneController.clear();
      });
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked.toString().isNotEmpty){
      return picked ;
    }
  }

  @override
  Widget build(BuildContext context) {
    String items1 = '';
    for (int i = 0; i < list1.length; i++) {
      items1 += list1[i];
      if (i < list1.length - 1) {
        items1 += ' , ';
      }
    }
    String items2 = '';
    for (int i = 0; i < list2.length; i++) {
      items2 += list2[i];
      if (i < list2.length - 1) {
        items2 += ' , ';
      }
    }
    String items3='';
    for (int i = 0; i < list3.length; i++) {
      items3 += list3[i];
      if (i < list3.length - 1) {
        items3 += ' , ';
      }
    }
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme:widget.isDarkMode?ThemeData.dark().copyWith(
          backgroundColor: Colors.grey[900], // Change the background color
          hintColor: Colors.white,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black), // Change the text color
            bodyText2: TextStyle(color: Colors.white),

          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
          ),
          expansionTileTheme: ExpansionTileThemeData(
            backgroundColor: Colors.black,
            collapsedBackgroundColor: Colors.green[700],
            collapsedIconColor: Colors.white,
            textColor: Colors.black,
            collapsedTextColor: Colors.black,
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
           body: Form(
             key: _formKey,
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   SizedBox(height: 50,),
                   Center(
                     child: Row(
                       children: [
                         SizedBox(width: 16,),
                         Column(
                           children: [
                             Icon(Icons.settings,color: Colors.black,size: 35,),
                             Text("Language",style: TextStyle(fontSize: 20),),
                           ],
                         ),
                         SizedBox(width: 27,),
                         SizedBox(
                           height: 115,
                           width: 115,
                           child: Stack(
                             clipBehavior: Clip.none,
                             fit: StackFit.expand,
                             children: [
                               CircleAvatar(
                                 backgroundImage: NetworkImage("https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"),
                               ),
                               Positioned(
                                   bottom: 0,
                                   right: -29,
                                   child: RawMaterialButton(
                                     onPressed: () {

                                     },
                                     elevation: 0,
                                     fillColor: Color(0xFFF5F6F9),
                                     child: Icon(Icons.camera_alt, color: Colors.black,size: 25,),
                                     padding: EdgeInsets.all(7.5),
                                     shape: CircleBorder(),
                                   )),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
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
                                       Expanded(
                                         child: TextFormField(
                                           decoration: InputDecoration(
                                             border: InputBorder.none
                                           ),
                                           controller: nameController,
                                           cursorColor: Colors.green[700],
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter your name';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 0,),
                                   Row(children: [
                                     Text("Your ID",style:TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                     SizedBox(width: 70,),
                                     Expanded(
                                       child: DropdownButtonFormField(
                                         decoration: InputDecoration(
                                             border: InputBorder.none
                                         ),
                                         value: dropdownValue1,
                                         items: <String>['id', 'passport']
                                             .map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(
                                               value,
                                               style: TextStyle(fontSize: 15,color: Colors.green[700]),
                                             ),
                                           );
                                         }).toList(),
                                         onChanged: (String? newValue) {
                                           setState(() {
                                             dropdownValue1 = newValue!;
                                           });
                                         },
                                         icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green[700],),
                                         validator: (value) {
                                           if (value!.isEmpty) {
                                             return 'Please choose';
                                           }
                                           return null;
                                         },
                                       ),
                                     ),
                                     SizedBox(width: 9,),
                                     Expanded(child: TextFormField(
                                       controller: idController,
                                       decoration: InputDecoration(
                                         border: InputBorder.none
                                       ),
                                       cursorColor: Colors.green[700],
                                       validator: (value) {
                                         if (value!.isEmpty) {
                                           return 'Please enter your id';
                                         }
                                         return null;
                                       },
                                     ))
                                   ],),
                                   SizedBox(height: 0,),
                                   Row(
                                     children: [
                                       Text("Gender",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                       SizedBox(width: 50,),
                                       Radio(
                                         value: 1,
                                         groupValue: id,
                                         onChanged: (val) {
                                           setState(() {
                                             radioButtonItem = 'Male';
                                             id = 1;
                                           });
                                         },
                                       ),
                                       Icon(Icons.male,color: Colors.blue,),
                                       SizedBox(width: 2,),
                                       Text(
                                         'Male',
                                         style: new TextStyle(fontSize: 14.0),
                                       ),
                                       Radio(
                                         value: 2,
                                         groupValue: id,
                                         onChanged: (val) {
                                           setState(() {
                                             radioButtonItem = 'Female';
                                             id = 2;
                                           });
                                         },
                                       ),
                                       Icon(Icons.female,color: Colors.pink,),
                                       SizedBox(width: 2,),
                                       Text(
                                         'Female',
                                         style: new TextStyle(
                                           fontSize: 14.0,
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 8,),
                                   Row(
                                     children: [
                                       Text("Date of Birth",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                       SizedBox(width: 40,),
                                       Expanded(
                                         child: TextFormField(
                                             controller: dateController, //editing controller of this TextField
                                             decoration: const InputDecoration(
                                                 icon: Icon(Icons.calendar_month,color: Colors.green,),
                                                 border: InputBorder.none//icon of text field
                                             ),
                                             readOnly: true,  // when true user cannot edit text
                                             onTap: () async {
                                               DateTime? pickedDate = await showDatePicker(
                                                   context: context,
                                                   initialDate: DateTime.now(), //get today's date
                                                   firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                                   lastDate: DateTime(2101)
                                               );
                                               if(pickedDate != null ){
                                                 print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                                 String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                                 print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                                 //You can format date as per your need
                                                 setState(() {
                                                   dateController.text = formattedDate; //set foratted date to TextField value.
                                                 });
                                               }else{
                                                 print("Date is not selected");
                                               }
                                             },
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter your Date of birth';
                                             }
                                             return null;
                                           },
                                         )
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 1,),
                                   Row(children: [
                                       Text("Personal Address",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 12),),
                                       SizedBox(width: 16,),
                                       Expanded(
                                         child: TextFormField(
                                           controller: addressController,
                                           decoration: InputDecoration(
                                             border: InputBorder.none
                                           ),
                                           cursorColor: Colors.green[700],
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter your Personal Address';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(height: 0,),
                                   Row(children: [
                                     Text("City",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                     SizedBox(width: 81,),
                                     Expanded(
                                       child: DropdownButtonFormField(
                                         decoration: InputDecoration(
                                           border: InputBorder.none
                                         ),
                                         value: dropdownValue2,
                                         items: <String>['Cairo', 'Giza','Alex','Assyut','Aswan']
                                             .map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(
                                               value,
                                               style: TextStyle(fontSize: 15,color: Colors.green[700]),
                                             ),
                                           );
                                         }).toList(),
                                         onChanged: (String? newValue) {
                                           setState(() {
                                             dropdownValue2 = newValue!;
                                           });
                                         },
                                         icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green[700],),
                                         hint: Text("Choose your city              "),
                                         validator: (value) {
                                           if (value!.isEmpty) {
                                             return 'Please choose your city';
                                           }
                                           return null;
                                         },
                                       ),
                                     ),
                                   ],),
                                   SizedBox(height: 0,),
                                   Row(children: [
                                     Text("Region",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                     SizedBox(width: 65,),
                                     Expanded(
                                       child: DropdownButtonFormField(
                                         decoration: InputDecoration(
                                             border: InputBorder.none
                                         ),
                                         value: dropdownValue3,
                                         items: <String>['Tagamo3', 'Nasr City','Masr elgdeda']
                                             .map<DropdownMenuItem<String>>((String value) {
                                           return DropdownMenuItem<String>(
                                             value: value,
                                             child: Text(
                                               value,
                                               style: TextStyle(fontSize: 15,color: Colors.green[700]),
                                             ),
                                           );
                                         }).toList(),
                                         onChanged: (String? newValue) {
                                           setState(() {
                                             dropdownValue3 = newValue!;
                                           });
                                         },
                                         hint: Text("select your region            "),
                                         icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green[700],),
                                         validator: (value) {
                                           if (value!.isEmpty) {
                                             return 'Please choose your region';
                                           }
                                           return null;
                                         },
                                       ),
                                     ),
                                   ],),
                                   Row(
                                     children: [
                                       Text("Mobile",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                       SizedBox(width: 70,),
                                       Expanded(
                                         child: IntlPhoneField(
                                           decoration: InputDecoration(
                                             border: InputBorder.none
                                           ),
                                           onChanged: (phone) {
                                             setState(() {
                                               phoneNumber = phone.completeNumber;
                                             });
                                           },
                                           keyboardType: TextInputType.phone,
                                           initialCountryCode: 'EG',
                                           validator: (value) {
                                             if (value.toString().isEmpty) {
                                               return 'Please enter your phone';
                                             }
                                             return null;
                                           },
                                         ),
                                       )
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Text("Email",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                       SizedBox(width: 81,),
                                       Expanded(
                                         child: TextFormField(
                                           controller: emailController,
                                           decoration: InputDecoration(
                                             border: InputBorder.none
                                           ),
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter your email';
                                             } else if (!EmailValidator.validate(value)) {
                                               return 'Please enter a valid email';
                                             }
                                             return null;
                                           },
                                           cursorColor: Colors.green[700],

                                         ),
                                       ),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Text("Password",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                       SizedBox(width: 56,),
                                       Expanded(
                                         child: TextFormField(
                                           decoration: InputDecoration(
                                               border: InputBorder.none
                                           ),
                                           controller: passwordController,
                                           cursorColor: Colors.green[700],
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter your Password';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Text("Confirm Password",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                       SizedBox(width: 8,),
                                       Expanded(
                                         child: TextFormField(
                                           decoration: InputDecoration(
                                               border: InputBorder.none
                                           ),
                                           controller: confirmPasswordController,
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter your password again';
                                             } else if (value != passwordController.text) {
                                               return 'Passwords do not match';
                                             }
                                             return null;
                                           },
                                           cursorColor: Colors.green[700],
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
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
                             padding: const EdgeInsets.only(left: 15,right: 10),
                             child: Column(
                               children: [
                                 Row(children: [
                                   Text("Main Speciality",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                   SizedBox(width: 40,),
                                   Expanded(
                                     child: DropdownButtonFormField(
                                       decoration: InputDecoration(
                                           border: InputBorder.none
                                       ),
                                       value: dropdownValue4,
                                       items: <String>['Cardiology', 'Otorhinolaryngology','Pediatric surgery','Nuclear medicine','Neonatology']
                                           .map<DropdownMenuItem<String>>((String value) {
                                         return DropdownMenuItem<String>(
                                           value: value,
                                           child: Text(
                                             value,
                                             style: TextStyle(fontSize: 15,color: Colors.green),
                                           ),
                                         );
                                       }).toList(),
                                       onChanged: (String? newValue) {
                                         setState(() {
                                           dropdownValue4 = newValue!;
                                         });
                                       },
                                       icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green[700],),
                                       hint: Text("Choose your     sd      "),
                                       validator: (value) {
                                         if (value!.isEmpty) {
                                           return 'Please choose your Main Speciality';
                                         }
                                         return null;
                                       },
                                     ),
                                   ),
                                 ],),
                                 Row(children: [
                                   Text("Sub speciality",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                   SizedBox(width: 50,),
                                   Expanded(
                                     child: DropdownButtonFormField(
                                       decoration: InputDecoration(
                                           border: InputBorder.none
                                       ),
                                       value: dropdownValue5,
                                       items: <String>['Cardiology', 'Otorhinolaryngology','Pediatric surgery','Nuclear medicine','Neonatology']
                                           .map<DropdownMenuItem<String>>((String value) {
                                         return DropdownMenuItem<String>(
                                           value: value,
                                           child: Text(
                                             value,
                                             style: TextStyle(fontSize: 15,color: Colors.green),
                                           ),
                                         );
                                       }).toList(),
                                       onChanged: (String? newValue) {
                                         setState(() {
                                           dropdownValue5 = newValue!;
                                         });
                                       },
                                       icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green[700],),
                                       hint: Text("Choose your     ss      "),
                                       validator: (value) {
                                         if (value!.isEmpty) {
                                           return 'Please choose your Sub Speciality';
                                         }
                                         return null;
                                       },
                                     ),
                                   ),
                                 ],),
                                 Row(children: [
                                   Text("Sceintific degree",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                   SizedBox(width: 33,),
                                   Expanded(
                                     child: DropdownButtonFormField(
                                       decoration: InputDecoration(
                                           border: InputBorder.none
                                       ),
                                       value: dropdownValue6,
                                       items: <String>['Master of Clinical Medicine', 'Master of Public Health (MPH)','Master of Medicine (MM, MMed)','Master of Philosophy (MPhil)']
                                           .map<DropdownMenuItem<String>>((String value) {
                                         return DropdownMenuItem<String>(
                                           value: value,
                                           child: Text(
                                             value,
                                             style: TextStyle(fontSize: 10.5,color: Colors.green,fontWeight: FontWeight.w500),
                                           ),
                                         );
                                       }).toList(),
                                       onChanged: (String? newValue) {
                                         setState(() {
                                           dropdownValue6 = newValue!;
                                         });
                                       },
                                       icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.green[700],),
                                       hint: Text(""),
                                       validator: (value) {
                                         if (value!.isEmpty) {
                                           return 'Please choose your Scientific Degree';
                                         }
                                         return null;
                                       },
                                     ),
                                   ),
                                 ],),
                                 Row(
                                   children: [
                                     Text("Clinic Name",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                     SizedBox(width: 62,),
                                     Expanded(
                                       child: TextField(
                                         decoration: InputDecoration(
                                             border: InputBorder.none,
                                         ),
                                         controller: clinicNameController,
                                         cursorColor: Colors.green[700],
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   children: [
                                     Text("Clinic Address",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                     SizedBox(width: 49,),
                                     Expanded(
                                       child: TextField(
                                         decoration: InputDecoration(
                                             border: InputBorder.none
                                         ),
                                         controller: clinicAddressController,
                                         cursorColor: Colors.green[700],
                                       ),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   children: [
                                     Text("Clinic phone",style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                     SizedBox(width: 62,),
                                     Expanded(
                                       child: TextField(
                                         decoration: InputDecoration(
                                           border: InputBorder.none
                                         ),
                                         controller: clinicPhoneController,
                                         cursorColor: Colors.green[700],
                                       ),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: 20,),
                                 GestureDetector(
                                   child: Row(
                                     children: [
                                       SizedBox(width: 240,),
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
                                   onTap: (){
                                     if(clinicNameController.text.isEmpty||clinicPhoneController.text.isEmpty||clinicAddressController.text.isEmpty){
                                       ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(
                                             content: Text('You must fill in the three spaces'),
                                           )
                                       );
                                     }
                                      else{ _addResults();}

                                   },
                                 ),
                                 SizedBox(height: 10,),
                                 Container(
                                   width: 700,
                                   child: DataTable(
                                     decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green.shade700),
                                       // borderRadius: BorderRadius.circular(10.0),
                                     ),
                 columnSpacing: 0.5,
                                     dataRowHeight: 30.0,
                 columns: [
                   DataColumn(label: Text('Clinic Name')),
                   DataColumn(label: Text('Clinic Address')),
                   DataColumn(label: Text('Clinic Phone')),
                 ],
                 rows: _results.map((result) {
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
                                     onTap: _openFilePicker
                                     ),
                                     SizedBox(width: 60,),
                                     Text("Upload Photo",style: TextStyle(color: Colors.green),),
                                   ],
                                 ),
                                 SizedBox(height: 3,),
                                 if (filePath1 != null)
                                   Text('File link: $filePath1',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                 SizedBox(height: 7,),
                                 Row(
                                   children: [
                                     Text("Upload license",style: TextStyle(color: Colors.green[700],fontWeight: FontWeight.w500,fontSize: 13),),
                                     SizedBox(width: 37,),
                                     GestureDetector(child: Icon(Icons.upload,size: 30,color:Colors.black,),
                                         onTap: _openFilePicker2
                                     ),
                                     SizedBox(width: 60,),
                                     Text("Upload Photo",style: TextStyle(color: Colors.green),),
                                   ],
                                 ),
                                 SizedBox(height: 3,),
                                 if (filePath2 != null)
                                   Text('File link: $filePath2',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
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
                                     controller: diagnosisController,
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
                                           if(diagnosisController.text.isNotEmpty){
                                             _addItemToList1(diagnosisController.text);
                                           }else{

                                           }
                                         },
                                       ),
                                       hintText: "Please add diagnosis if any",
                                     ),
                                   ),
                                 ),
                               ],),
                               if (list1.isNotEmpty)
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
                                     controller: operationsController,
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       suffixIcon: IconButton(
                                         icon: Container(
                                             decoration: BoxDecoration(
                                               color: Colors.green[400],
                                               borderRadius: BorderRadius.circular(25.0),
                                             ),
                                             child: Icon(Icons.add,color: Colors.white,)),
                                         onPressed: (){
                                           if(operationsController.text.isNotEmpty){
                                             _addItemToList2(operationsController.text);
                                           }else{

                                           }
                                         },
                                       ),
                                       hintText: "Please add previous operations if any",
                                     ),
                                   ),
                                 ),
                               ],),
                               if (list2.isNotEmpty)
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
                                     controller: medicationsController,
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
                                          if(medicationsController.text.isNotEmpty){
                                               _addItemToList3(medicationsController.text);
                                                       }else{
                                                  }
                                                        },
                                       ),
                                       hintText: "Please add medications if any",
                                     ),
                                   ),
                                 ),
                               ],),
                               if (list3.isNotEmpty)
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
                                   Text("Describe your condition \n             by video",style: TextStyle(fontSize: 16),),
                                   SizedBox(width: 46,),
                                   IconButton(onPressed: _openvideoPicker, icon: Icon(Icons.upload,size: 35,)),
                                   IconButton(onPressed: _openvideoPicker, icon: Icon(Icons.videocam,size: 35,color: Colors.green[700],)),
                                 ],
                               ),
                               SizedBox(height: 5,),
                               if (videoPath != null)
                                 Text('Video link: $videoPath',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                               Row(
                                 children: [
                                   Text("Describe your condition \n             by voice",style: TextStyle(fontSize: 16),),
                                   SizedBox(width: 46,),
                                   IconButton(onPressed: _openaudioPicker, icon: Icon(Icons.upload,size: 35,)),
                                   IconButton(onPressed: (){}, icon: Icon(Icons.mic,size: 35,color: Colors.green[700],)),
                                 ],
                               ),
                               if(isRecording)
                                 Text("Recording in Progress",style: TextStyle(fontSize: 20,color: Colors.green),) ,
                               ElevatedButton(onPressed: isRecording?stopRecording:StartRecording,
                                   child:isRecording? Text("Stop Recording"):Text("Start Recording")
                               ),
                               SizedBox(height: 25,),
                               if(!isRecording && audioPath != null)
                                 ElevatedButton(onPressed: playRecording, child: Text("Play Recording")),
                               SizedBox(height: 5,),
                               if (audioPath != null)
                                 Text('Audio link: $audioPath',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                             ],),
                           ),

                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 40,),
                   MyButton(
                       onTap: () async {
                         if(_formKey.currentState!.validate()) {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) =>
                                   SettingsPage1(fullname: nameController.text,
                                       id: dropdownValue1,
                                       id2: idController.text,
                                       Gender: radioButtonItem,
                                       Date: dateController.text,
                                       address: addressController.text,
                                       city: dropdownValue2,
                                       region: dropdownValue3,
                                       mobile: mobileController.text,
                                       Email: emailController.text,
                                       password: passwordController.text,
                                       mainspec: dropdownValue4,
                                       subspec: dropdownValue5,
                                       scideg: dropdownValue6,
                                       filePath1: filePath1,
                                       lice: filePath2,
                                       list1: list1,
                                       list2: list2,
                                       list3: list3,
                                       video: videoPath,
                                       audio: audioPath,
                                       dataList: _results,
                                       phoneNumber: phoneNumber, ),
                             ),
                           );
                         }
                       }, text: "Sign up")
                  ],
               ),
             ),
           ),
        ),
    );

  }
  Future<void> _createDatabase() async {
    _database = await openDatabase(
      _dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, mobile TEXT, address TEXT, password TEXT, id1 TEXT, id2 TEXT, date TEXT, gender TEXT, city TEXT, region TEXT, mainspec TEXT, subspec TEXT, scideg TEXT, file1 TEXT, file2 TEXT, video TEXT, audio TEXT, diag TEXT, oper TEXT, med TEXT)',
        );
      },
    );
  }

  Future<void> _insertData() async {
    final data = {
      'name': nameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
      'address': addressController.text,
      'password': passwordController.text,
      'id1': dropdownValue1,
      'id2': idController.text,
      'date': dateController.text,
      'gender': radioButtonItem,
      'city': dropdownValue2,
      'region': dropdownValue3,
      'mainspec': dropdownValue4,
      'subspec': dropdownValue5,
      'scideg': dropdownValue6,
      'file1': filePath1,
      'file2': filePath2,
      'video': videoPath,
      'audio': audioPath,
      'diag' : items11 ,
      'oper' : items22 ,
      'med'  : items33 ,

    };
    await _database.insert('users', data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data inserted successfully'),
      ),
    );
  }
  Future<List<Map<String, dynamic>>> _getUserData() async {
    final List<Map<String, dynamic>> dataList = await _database.query('users');
    return dataList;
  }

}
