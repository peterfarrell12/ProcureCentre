// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart' as fb;
// import 'package:firebase/firestore.dart' as fs;

// import '../../project_repository.dart';

// class ExtractionScreen extends StatefulWidget {
//   final Project project;
//   final String company;

//   //CurrentProjectBloc currentProjectBloc;


//   ExtractionScreen(this.project, this.company);
//   @override
//   _ExtractionScreenState createState() => _ExtractionScreenState();
// }

// class _ExtractionScreenState extends State<ExtractionScreen> {
//           fs.Firestore store = fb.firestore();

//   fb.UploadTask _uploadTask;
//   //CurrentProjectBloc _currentProjectBloc;
//   //CurrentProjectBloc get _currentProjectBloc => widget.currentProjectBloc;
//   Project get _project => widget.project;
//   String get _company => widget.company;
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final fs.Firestore firestore = fb.firestore();
//     //final fb.StorageReference ref = fb.storage().ref();

//     return Scaffold(
//       body: Container(
//         width: width,
//         child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 18.0),
//                 child: Text(
//                   'Mah Links',
//                   style: TextStyle(
//                     fontFamily: 'Karla',
//                     fontSize: 20,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * .4,
//                 width: MediaQuery.of(context).size.width * .4,
//                 child: ListView.builder(
                  
//                   itemCount: _project.fileNames.length,
//                   itemBuilder: (BuildContext context, int index) {
//                   var keys = _project.fileNames.keys.toList();

//                   return ListTile(
//                     title: Text(keys[index].toString()),
//                     subtitle: Text(_project.fileNames[keys[index]]),
//                   );
//                  },
//                 ),
//               )
//               // StreamBuilder<fb.UploadTaskSnapshot>(
//               //   stream: _uploadTask?.onStateChanged,
//               //   builder: (context, snapshot) {
//               //     final event = snapshot?.data;

//               //     // Default as 0
//               //     double progressPercent = event != null
//               //         ? event.bytesTransferred / event.totalBytes * 100
//               //         : 0;

//               //     if (progressPercent == 100) {
//               //       return Text('Successfully uploaded file 🎊');
//               //     } else if (progressPercent == 0) {
//               //       return SizedBox();
//               //     } else {
//               //       return LinearProgressIndicator(
//               //         value: progressPercent,
//               //       );
//               //     }
//               //   },
//               // ),
//             ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         heroTag: 'picker',
//         elevation: 0,
//         backgroundColor: Colors.tealAccent[400],
//         hoverElevation: 0,
//         label: Row(
//             children: <Widget>[
//               Icon(Icons.file_upload),
//               SizedBox(width: 10),
//               Text('Upload Image')
//             ],
//         ),
//         onPressed: () => uploadImage(),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
              
              
       
//   }

//   /// Upload file to firebase storage and updates [_uploadTask] to the latest
//   /// file upload
//   uploadToFirebase(File imageFile) async {
//     print('hello');
//     final filePath = '${imageFile.name} ${DateTime.now()}';
//     setState(() {
//       print('work');
//       _uploadTask = fb.storage().ref('/Files/procurecentre.appspot.com/PDFs')
//           .child(filePath)
//           .put(imageFile);
//       store.collection('companies').doc(_company).collection('projects').doc(_project.id).set({'Files' : {'newTestFile' : 'newTestURL'}},fs.SetOptions(merge: true));
//       //update(data: {'Files':'downloadUrlTest', }, fieldsAndValues: );

//     });
//   }

//   /// A "select file/folder" window will appear. User will have to choose a file.
//   /// This file will be then read, and uploaded to firebase storage;
//   uploadImage() async {
//     // HTML input element
//     InputElement uploadInput = FileUploadInputElement();
//     uploadInput.click();

//     uploadInput.onChange.listen(
//       (changeEvent) {
//         final file = uploadInput.files.first;
//         final reader = FileReader();
//         reader.readAsDataUrl(file);
//         reader.onLoadEnd.listen(
//           (loadEndEvent) async {
//             uploadToFirebase(file);
//           //   print('getting to load end event');
//           //   BlocProvider.of<ProjectsBloc>(context).add(
//           //          AddProjectFile(_project, _company, file)
//           //         );

//            },
//         );
//       },
//     );
//   }
// }



