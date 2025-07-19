
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:qaudit_tata_flutter/utils/app_theme.dart';
import 'package:qaudit_tata_flutter/view/audit_form_screen.dart';
import 'package:qaudit_tata_flutter/view/edit_audit_form_screen.dart';
import 'package:qaudit_tata_flutter/view/zoom_scaffold.dart' as MEN;

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../network/Utils.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/loader.dart';
import '../utils/app_modal.dart';
import 'menu_screen.dart';

class SavedAuditListScreen extends StatefulWidget
{
  SavedAuditState createState()=>SavedAuditState();
}

class SavedAuditState extends State<SavedAuditListScreen> with TickerProviderStateMixin
{
  int selectedIndex = 0;
  MEN.MenuController? menuController;
  final ZoomDrawerController controller = ZoomDrawerController();
  bool isLoading=false;
  List<dynamic> arrSavedAuditList=[];
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child:ChangeNotifierProvider(
        create: (context) => menuController,
        child: MEN.ZoomScaffold(
          menuScreen:  MenuScreen(),
          showBoxes: true,
          orangeTheme: false,
          pageTitle: "Saved Audit List",
          contentScreen: MEN.Layout(
              contentBuilder: (cc) => Column(
                children: [

                  SizedBox(height:20),

                  Expanded(
                      child:
                      isLoading?

                      Center(
                        child: Loader(),
                      ):

                      arrSavedAuditList.length==0?


                      Center(
                        child: Text("No Audits found!"),
                      ):

                      ListView.builder(
                      itemCount: arrSavedAuditList.length,
                      padding: EdgeInsets.only(top: 18),
                      itemBuilder: (BuildContext context,int pos)
                      {
                        return Column(
                          children: [

                            Card(
                              color: Colors.white,
                              shadowColor: AppTheme.themeColor,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              elevation: 2,
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7)
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(arrSavedAuditList[pos]['agency_name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.grey,
                                        )),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [

                                        Text("Audit Type",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            )),

                                        SizedBox(width: 10),

                                        Text(arrSavedAuditList[pos]['audit_type'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),

                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [

                                        Text("Product Name",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            )),

                                        SizedBox(width: 10),

                                        Text(arrSavedAuditList[pos]['product'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),




                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [

                                        Text("Collection Manager",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            )),

                                        SizedBox(width: 10),

                                        Text(arrSavedAuditList[pos]['collection_manager'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),




                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [

                                        Text("Visited Date Time",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            )),

                                        SizedBox(width: 10),

                                        Text(arrSavedAuditList[pos]['audit_date'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),




                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [

                                        Text("Audit Id",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            )),

                                        SizedBox(width: 10),

                                        Text(arrSavedAuditList[pos]['audit_id_show'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),




                                      ],
                                    ),


                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(child: InkWell(
                                          onTap: () {
                                            String qmSheetID=arrSavedAuditList[pos]["qm_sheet_id"].toString();
                                            String sheetType=arrSavedAuditList[pos]["audit_type"];
                                            String auditID=arrSavedAuditList[pos]["audit_id"].toString();
                                            String auditDate=arrSavedAuditList[pos]["audit_date"];
                                            String auditCycle=arrSavedAuditList[pos]["audit_cycle_id"].toString();
                                            String sheetLOBName=arrSavedAuditList[pos]["lob"];
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>EditAuditFormScreen(qmSheetID,sheetLOBName,sheetType,auditID,auditDate,auditCycle,false)));
                                          },
                                          child: Container(
                                              margin:
                                              const EdgeInsets.only(left: 0,right: 8,top: 8,bottom: 5),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.themeColor,
                                                  borderRadius: BorderRadius.circular(5)),
                                              height: 45,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset("assets/edit_icon.png",width: 20,height: 20),
                                                    SizedBox(width: 10),
                                                    Text('Edit',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white)),

                                                  ],
                                                )
                                              )),
                                        ),),
                                        Expanded(child: InkWell(
                                          onTap: () {
                                            String qmSheetID=arrSavedAuditList[pos]["qm_sheet_id"].toString();
                                            String sheetType=arrSavedAuditList[pos]["audit_type"];
                                            String auditID=arrSavedAuditList[pos]["audit_id"].toString();
                                            String auditDate=arrSavedAuditList[pos]["audit_date"];
                                            String auditCycle=arrSavedAuditList[pos]["audit_cycle_id"].toString();
                                            String sheetLOBName=arrSavedAuditList[pos]["lob"];
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>EditAuditFormScreen(qmSheetID,sheetLOBName,sheetType,auditID,auditDate,auditCycle,true)));
                                          },
                                          child: Container(
                                              margin:
                                              const EdgeInsets.only(left: 8,right: 0,top: 8,bottom: 5),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.blueColor,
                                                  borderRadius: BorderRadius.circular(5)),
                                              height: 45,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset("assets/copy_icon.png",width: 20,height: 20),
                                                    SizedBox(width: 10),
                                                    Text('Copy',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white)),

                                                  ],
                                                )
                                              )),
                                        )),
                                      ],
                                    ),



                                  ],
                                ),




                              ),
                            ),

                            SizedBox(height: 12)

                          ],
                        );
                      }


                  ))

                ],
              )),
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savedAuditList(context);
    menuController = MEN.MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  savedAuditList(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "user_id":AppModel.userID
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('savedAuditList', data, context);
    var responseJSON = json.decode(response.body);
    arrSavedAuditList = responseJSON['data'];
    setState(() {
      isLoading=false;
    });
    print(responseJSON);
/*    if (responseJSON['status'] == 1) {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);

    } else {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }*/


   // completedAuditList=responseJSON["data"];
    setState(() {

    });

  }
}

