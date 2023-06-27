// import 'package:flutter/cupertino.dart';
//
// class SignUp1 extends StatelessWidget {
//   SignUp1({Key? key}) : super(key: key);
//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final addressController = TextEditingController();
//   final mobileController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final clinicNameController = TextEditingController();
//   final clinicPhoneController = TextEditingController();
//   final clinicAddressController = TextEditingController();
//   final diagnosisController = TextEditingController();
//   final operationsController = TextEditingController();
//   final medicationsController = TextEditingController();
//   final dateController = TextEditingController();
//   final idController = TextEditingController();
//   String items11 = '';
//   String items22 = '';
//   String items33 = '';
//   String dropdownValue1 = 'id';
//   String dropdownValue2 = 'Cairo';
//   String dropdownValue3 = 'Tagamo3';
//   String dropdownValue4 = 'Cardiology';
//   String dropdownValue5 = 'Cardiology';
//   String dropdownValue6 = 'Master of Clinical Medicine';
//   String radioButtonItem = 'Male';
//   late String phoneNumber;
//   int id = 1;
//   final List<String> list1 = [];
//   final List<String> list2 = [];
//   final List<String> list3 = [];
//   File? _videoFile;
//   File? _voiceRecordFile;
//   File? _file;
//   DateTime? selectedDate;
//   final _dbPath = 'my_database.db';
//   late Database _database;
//   String filePath1='';
//   String filePath2='';
//   String videoPath='';
//   String audioPath='';
//
//
//   @override
//   void initState() {
//     super.initState();
//     _createDatabase();
//   }
//
//   void _addItemToList1(String item) {
//     setState(() {
//       list1.add(item);
//       diagnosisController.clear();
//     });
//   }
//   void _addItemToList2(String item) {
//     setState(() {
//       list2.add(item);
//       operationsController.clear();
//     });
//   }
//   void _addItemToList3(String item) {
//     setState(() {
//       list3.add(item);
//       medicationsController.clear();
//     });
//   }
//
//   void _openFilePicker() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         filePath1 = result.files.single.path!;
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('File Uploaded Succesfulyy'),
//             )
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Upload file agian'),
//           )
//       );
//     }
//   }
//   void _openFilePicker2() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         filePath2 = result.files.single.path!;
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('File Uploaded Succesfulyy'),
//             )
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Upload file agian'),
//           )
//       );
//     }
//   }
//   void _openvideoPicker() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         videoPath = result.files.single.path!;
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Vidoe Uploaded Succesfulyy'),
//             )
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Upload Video agian'),
//           )
//       );
//     }
//   }
//   void _openaudioPicker() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         audioPath = result.files.single.path!;
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('audio Uploaded Succesfulyy'),
//             )
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Upload audio agian'),
//           )
//       );
//     }
//   }
//   void _openphotoPicker() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         filePath1 = result.files.single.path!;
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('photo Uploaded Succesfulyy'),
//             )
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Upload photo agian'),
//           )
//       );
//     }
//   }
//   List<Map<String, dynamic>> _results = [];
//   void _addResults() {
//     String clinicname = clinicNameController.text;
//     String clinicAddress = clinicPhoneController.text;
//     String clinicPhone = clinicAddressController.text;
//
//     if (clinicname.isNotEmpty && clinicAddress.isNotEmpty && clinicPhone.isNotEmpty) {
//       setState(() {
//         _results.add({
//           'clinicname': clinicname,
//           'clinicAddress': clinicAddress,
//           'clinicphone': clinicPhone,
//         });
//         clinicNameController.clear();
//         clinicAddressController.clear();
//         clinicPhoneController.clear();
//       });
//     }
//   }
//
//   Future<DateTime?> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2015, 8),
//       lastDate: DateTime(2101),
//     );
//     if (picked.toString().isNotEmpty){
//       return picked ;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String items1 = '';
//     for (int i = 0; i < list1.length; i++) {
//       items1 += list1[i];
//       if (i < list1.length - 1) {
//         items1 += ' , ';
//       }
//     }
//     String items2 = '';
//     for (int i = 0; i < list2.length; i++) {
//       items2 += list2[i];
//       if (i < list2.length - 1) {
//         items2 += ' , ';
//       }
//     }
//     String items3='';
//     for (int i = 0; i < list3.length; i++) {
//       items3 += list3[i];
//       if (i < list3.length - 1) {
//         items3 += ' , ';
//       }
//     }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
