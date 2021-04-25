import 'dart:io';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;

class RapportView extends StatefulWidget {
  RapportView({Key key, this.mysinistre}) : super(key: key);



final Mysinistre mysinistre;

  @override
  _RapportViewState createState() => _RapportViewState();
}

class _RapportViewState extends State<RapportView> {


  bool isDownload=false;

 


  Future<void> downloadFile(String url)async{


  Directory appDocDir = await path.getExternalStorageDirectory();

  String appDocPath = appDocDir.path;

print(appDocPath);

    HttpClient client = new HttpClient();
    
  await client.getUrl(Uri.parse(url.split("@")[0]))
  .then((HttpClientRequest request) {
    return request.close();
  })
  .then((HttpClientResponse response) async{
      await response.pipe(new File(appDocPath+"/${response.hashCode}.${url.split("@")[1]}").openWrite());
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                                  appBar: AppBar(
                                    title: Text("Rapport Info"),
                                  ),
                                    body: Container(
                                      width: double.infinity,
                                      color: Colors.grey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Parcelle ID : ${widget.mysinistre.parcelleID}"),
                                          Text("Agriculteur ID : ${widget.mysinistre.agriId}"),
                                          Text("Expert ID : ${widget.mysinistre.whocansee}"),
                                          Text("Sinistre ID : ${widget.mysinistre.sinisteid}"),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          GestureDetector(
                                          child: AnimatedContainer(
                                            height: 50,
                                            width: !isDownload ?200:50,
                                            duration: Duration(milliseconds: 200),
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(isDownload ? 25.0:5.0)
                                            ),
                                            child: Center(
                                              child: isDownload? 
                                              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.redAccent),)
                                              :Text("Download attachement"),
                                              )
                                          ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          GestureDetector(
                                          child: Text("ANIMATE BUTTOM"),
                                          onTap: ()async{
                                            setState((){
                                              isDownload=true;
                                            });
                                            downloadFile(widget.mysinistre.filePath).then((value){
                                              setState((){
                                              isDownload=false;
                                            });
                                            });
                                          },
                                          ),
                                        ],
                                      ),
                                    ),
                            );
  }
}