import 'dart:html' as html;
import 'package:ProcureCentre/extraction/blocs/extraction_bloc/bloc.dart';
import 'package:ProcureCentre/extraction/widgets/service.dart';
import 'package:ProcureCentre/projects/bloc/blocs.dart';
import 'dart:typed_data';

import 'package:ProcureCentre/project_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExtractingScreen extends StatefulWidget {
  final Project project;
  final String company;

  ExtractingScreen(this.project, this.company);

  @override
  _ExtractingScreenState createState() => _ExtractingScreenState();
}

class _ExtractingScreenState extends State<ExtractingScreen> {
  Project get _project => widget.project;
  String get _company => widget.company;
  ExtractionBloc _extractionBloc;
  bool _chooseFile;
    List<int> _selectedFile;
  Uint8List _bytesData;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool failure = false;


  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e)   {
        //_handleResult(reader.result);
        //await sendFile(reader.result, file.name);
        BlocProvider.of<ExtractionBloc>(context).add(ExtractBegin(project: _project, company: _company,  rResult: reader.result, file: files));
            //uploadToFirebase(file);
              print('getting to load end event');
              BlocProvider.of<ProjectsBloc>(context).add(
                     AddProjectFile(_project, _company, file)
                    );
                    _chooseFile = !_chooseFile;
      });
      reader.readAsDataUrl(file);
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExtractionBloc, ExtractionState>(
      bloc: _extractionBloc,
      builder: (context, state) {
  
          return  Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * .3,
                child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Upload PDF File", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.blue
                                ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.file_upload),
                                    color: Colors.blue,
                          
                                      onPressed: () {
                                        startWebFilePicker();
                                      }),
                                ),
                              ],
                            ),
                          ),
                       
                                
                              
                            
                        
                        ],
                      ),
                    )),
              ),
            );
          
        }
      
    );
  } 
}

