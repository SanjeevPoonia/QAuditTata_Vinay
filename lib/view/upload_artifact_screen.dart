

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qaudit_tata_flutter/network/api_dialog.dart';
import 'package:qaudit_tata_flutter/network/constants.dart';
import 'package:qaudit_tata_flutter/utils/app_modal.dart';
import 'package:qaudit_tata_flutter/utils/app_theme.dart';
import 'package:qaudit_tata_flutter/view/upload_artifact_screen.dart';
import 'package:toast/toast.dart';

class UploadArtifactScreen extends StatefulWidget
{
  final String sheetID,paramID,subParamID,tempAuditID;
  UploadArtifactScreen(this.sheetID,this.paramID,this.subParamID,this.tempAuditID);
  ArtifactState createState()=>ArtifactState();
}

class ArtifactState extends State<UploadArtifactScreen>
{
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> imageList=[];

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
                  Text("Upload Artifact",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [

                SizedBox(width: 15),


                   Expanded(child: Card(
                          elevation: 2,
                          shadowColor:Colors.grey,
                          //  margin: EdgeInsets.symmetric(horizontal: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white), // background
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Color(0xFF708096)), // fore
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ))),
                              onPressed: () {
                                _openImagePicker(context);
                              },
                              child: const Text(
                                'Select Artifact',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),flex: 1),

                SizedBox(width: 5),


                Expanded(
                    child:

                    imageList.length==0?Container():

                    Card(
                      elevation: 2,
                      shadowColor: Colors.grey,
                      // margin: EdgeInsets.symmetric(horizontal: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<
                                  Color>(
                                  Colors.white), // background
                              backgroundColor:
                              MaterialStateProperty
                                  .all<Color>(AppTheme
                                  .themeColor), // fore
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(4.0),
                                  ))),
                          onPressed: () {


                            uploadImage();


                          },
                          child: const Text(
                            'UPLOAD',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    flex: 1),
              ],
            ),
          ),

          Expanded(child: ListView.builder(
              itemCount: imageList.length,
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
                            child: Image.file(File(imageList[pos].path.toString())),height: 200),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Row(
                            children: [

                              Expanded(child:  Text(imageList[pos].path.split('/').last,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ))),

                              SizedBox(width: 5),

                              GestureDetector(
                                onTap: (){
                                  imageList.removeAt(pos);
                                  setState(() {

                                  });
                                },
                                child: Text("Remove",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    )),
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
  Future<void> _openImagePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 29.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Set the corner radius here
              color: Colors.white, // Example color for the container
            ),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Take a picture'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? pickedFile = await _imagePicker.pickImage(
                        source: ImageSource.camera);
                    if (pickedFile != null) {
                      imageList.add(pickedFile);
                      // Process the picked image, for example, display it or upload it to a server
                      print('Selected Image Path: ${pickedFile.path}');
                      setState(() {

                      });
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Choose from gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? pickedFile = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imageList.add(pickedFile);
                      // Process the picked image, for example, display it or upload it to a server
                      print('Selected Image Path: ${pickedFile.path}');
                      setState(() {

                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );

      },
    );
  }

  uploadImage() async {

    for(int i=0;i<imageList.length;i++)
      {
        APIDialog.showAlertDialog(context, 'Uploading image...');
        FormData formData = FormData.fromMap({
          "sheet_id": widget.sheetID,
          "parameter_id": widget.paramID,
          "sub_parameter_id": widget.subParamID,
          "temp_audit_id":widget.tempAuditID,
          "audit_id":"",
          "status":"0",
          "totalFile":await MultipartFile.fromFile(imageList[i].path,filename:imageList[i].path.split('/').last),

        });
        print(formData.fields);
        Dio dio = Dio();
        dio.options.headers['Content-Type'] = 'multipart/form-data';
        dio.options.headers['Authorization'] = AppModel.token;
        print(AppConstant.appBaseURL + "storeArtifact");
        var response = await dio.post(AppConstant.appBaseURL + "storeArtifact",
            data: formData);
        log(response.data);
        var responseJSON = jsonDecode(response.data.toString());
        Navigator.pop(context);
        if (responseJSON['status'] == 1) {
          Toast.show(responseJSON['message'].toString(),
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
              backgroundColor: Colors.green);
          if(i==imageList.length-1)
            {
              Navigator.pop(context);
            }



        } else {
          Toast.show(responseJSON['message'].toString(),
              duration: Toast.lengthLong,
              gravity: Toast.bottom,
              backgroundColor: Colors.red);
        }
      }
  }
}