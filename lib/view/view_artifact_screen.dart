

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qaudit_tata_flutter/network/api_dialog.dart';
import 'package:qaudit_tata_flutter/network/api_helper.dart';
import 'package:qaudit_tata_flutter/network/constants.dart';
import 'package:qaudit_tata_flutter/network/loader.dart';
import 'package:qaudit_tata_flutter/utils/app_modal.dart';
import 'package:qaudit_tata_flutter/utils/app_theme.dart';
import 'package:qaudit_tata_flutter/view/upload_artifact_screen.dart';
import 'package:toast/toast.dart';

class ViewArtifactScreen extends StatefulWidget
{
  final String sheetID,paramID,subParamID,tempAuditID;
  ViewArtifactScreen(this.sheetID,this.paramID,this.subParamID,this.tempAuditID);
  ArtifactState createState()=>ArtifactState();
}

class ArtifactState extends State<ViewArtifactScreen>
{
  List<dynamic> imageList=[];
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: 25),
          Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Container(
              height: 69,
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_backspace_rounded,
                          color: Colors.black)),
                  Text("View Artifact",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                  Container()
                ],
              ),
            ),
          ),

          SizedBox(height: 16),
          Expanded(child:

          isLoading?

              Center(
                child:Loader()
              ):

              imageList.length==0?

                  Center(
                    child: Text("No Artifacts found!"),
                  ):


          ListView.builder(
              itemCount: imageList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context,int pos)
          {
            return Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  elevation: 3,
                  child: Container(
                    child: Column(
                      children: [

                        SizedBox(height: 5),
                        SizedBox(
                            child: Image.network(imageList[pos]["url"].toString()),height: 200),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          child: Row(
                            children: [

                             Spacer(),

                              GestureDetector(
                                onTap: (){
                                  deleteArtifacts(imageList[pos]["artifact_id"].toString(),pos);
                                },
                                child: Icon(Icons.delete,color: Colors.red),
                              )



                            ],
                          ),
                        ),















                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),
              ],
            );
          }


          ))

        ],
      ),
    );
  }



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchArtifacts();
  }

  fetchArtifacts() async {
    setState(() {
      isLoading = true;
    });
    var requestModel = {


      "sheet_id": widget.sheetID,
      "parameter_id": widget.paramID,
      "sub_parameter_id": widget.subParamID,
      "temp_audit_id":widget.tempAuditID,


    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('artifactsList', requestModel, context);
    setState(() {
      isLoading = false;
    });
    var responseJSON = json.decode(response.body);
    imageList = responseJSON["data"];

    print(responseJSON);
    setState(() {});
  }


  deleteArtifacts(String id,int pos) async {

    APIDialog.showAlertDialog(context, "Removing...");
    var requestModel = {


      "artifact_id": id


    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('deleteArtifact', requestModel, context);

    Navigator.pop(context);

    var responseJSON = json.decode(response.body);
    if (responseJSON['status'] == 200) {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);

     imageList.removeAt(pos);
     setState(() {

     });
    } else {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }

    print(responseJSON);
    setState(() {});
  }
}