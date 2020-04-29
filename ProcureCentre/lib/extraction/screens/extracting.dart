// import 'dart:html' as html;
// import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
// import 'package:ProcureCentre/extraction/widgets/service.dart';
// import 'package:ProcureCentre/projects/bloc/blocs.dart';
// import 'dart:typed_data';

// import 'package:ProcureCentre/project_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class ExtractingScreen extends StatefulWidget {
//   final Project project;
//   final String company;

//   ExtractingScreen(this.project, this.company);

//   @override
//   _ExtractingScreenState createState() => _ExtractingScreenState();
// }

// class _ExtractingScreenState extends State<ExtractingScreen> {
//   Project get _project => widget.project;
//   String get _company => widget.company;
//   ExtractionBloc _extractionBloc;
//   bool _chooseFile;
//     List<int> _selectedFile;
//   Uint8List _bytesData;
//   GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   bool failure = false;


//   startWebFilePicker() async {
//     html.InputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.multiple = true;
//     uploadInput.draggable = true;
//     uploadInput.click();

//     uploadInput.onChange.listen((e) async {
//       final files = uploadInput.files;
//       //final file = files[0];
//       Iterable<Future<String>> resultsFutures = files.map((file) {
//         final reader = html.FileReader();
//         reader.readAsDataUrl(file);
//         //reader.onError.listen((error) => completer.completeError(error));
//         return reader.onLoad.first.then((_) => reader.result as String);
//       });

//       final results = await Future.wait(resultsFutures);
//       BlocProvider.of<ExtractionBloc>(context).add(ExtractBegin(project: _project, company: _company,  rResult: results, file: files));
//        files.map((e) => BlocProvider.of<ProjectsBloc>(context).add(
//                      AddProjectFile(_project, _company, e)
//                     ));
//                     _chooseFile = !_chooseFile;
       

//       //r//eader.onLoadEnd.listen((e)   {
//         //_handleResult(reader.result);
//         //await sendFile(reader.result, file.name);
        
//             //uploadToFirebase(file);
             
     
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ExtractionBloc, ExtractionState>(
//       bloc: _extractionBloc,
//       builder: (context, state) {
  
//           return  Center(
//               child: Container(
//                 //height: MediaQuery.of(context).size.height * .4,
//                 width: MediaQuery.of(context).size.width * .5,
//                 child: Card(
//                     elevation: 0,
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Text(
                              
//                               "Invoice Data Extraction", style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Text("We use a third party API to extract the data from your invoices, called Rossum Elis, which uses the latest Artificial Intelligence to retrieve the data. Below you can upload a PDF/JPEG file which is then sent to the Rossum API. You will then be able to check these files by following the link provided. If you are not happy with the files you, the Rossum playground allows you to make changes. Once satifisfied, press the 'Complete' button and your data will appear!", maxLines: 3,overflow: TextOverflow.clip,),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                       "Upload PDF File", style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         //fontSize: 25,
//                                         color: Theme.of(context).primaryColor
//                                       ),),
//                                 ),
//                                 Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: IconButton(
//                                       icon: Icon(Icons.file_upload),
//                                       color: Theme.of(context).primaryColor,
                            
//                                         onPressed: () {
//                                           startWebFilePicker();
//                                         }),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                               ],
//                             ),
//                           ),
                          
                       
                                
                              
                            
                        
//                         ],
//                       ),
//                     )),
//               // ),
//             )
//           );
//         }
      
//     );
//   } 
// }

