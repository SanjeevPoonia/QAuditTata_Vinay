import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:qaudit_tata_flutter/network/api_dialog.dart';
import 'package:qaudit_tata_flutter/network/api_helper.dart';
import 'package:qaudit_tata_flutter/network/loader.dart';
import 'package:qaudit_tata_flutter/utils/app_modal.dart';
import 'package:qaudit_tata_flutter/utils/app_theme.dart';
import 'package:qaudit_tata_flutter/view/audit_form_screen.dart';
import 'package:qaudit_tata_flutter/view/view_artifact_screen.dart';
import 'package:qaudit_tata_flutter/widgets/dropdown_widget.dart';
import 'package:qaudit_tata_flutter/widgets/textfield_widget.dart';
import 'package:toast/toast.dart';

class ViewAuditFormScreen extends StatefulWidget {
  final String auditID;
  final String productName;
  final String auditType;
  final String cycleDate;

  ViewAuditFormScreen(this.auditID, this.productName, this.auditType,this.cycleDate);

  ViewAuditFormState createState() => ViewAuditFormState();
}

class ViewAuditFormState extends State<ViewAuditFormScreen> {
  bool isLoading = false;
  String finalGrade='';
  String totalScore="0";
  String agencyID = '';
  String yardID = '';
  String productID = '';
  String headerName = '';
  String sheetID = '';
  var dropdownSelectionList = [[]];
  List<String?> selectedDropCollectionManager=[];
  var weightList = [[]];
  var controllerList = [[]];
  List<dynamic> arrParameterList = [];
  List<dynamic> selectedManageList = [];
  String? selectedDate;
  var agencyNameController = TextEditingController();
  var agencyManagerNameController = TextEditingController();
  var agencyPhoneController = TextEditingController();
  var agencyAddressController = TextEditingController();
  var branchNameController = TextEditingController();
  var cityNameController = TextEditingController();
  var locationNameController = TextEditingController();
  var latLongController = TextEditingController();
  var managerEmpCodeController = TextEditingController();
  var regionalManagerController = TextEditingController();
  var zonalManagerController = TextEditingController();
  var nationalManagerController = TextEditingController();
  var yardController = TextEditingController();
  var lobController = TextEditingController();
  var auditController = TextEditingController();
  var auditDateController = TextEditingController();
  var productController = TextEditingController();
  var yardNameController = TextEditingController();
  var yardAddressController = TextEditingController();
  var branchCityNameController = TextEditingController();
  var areaCollManagerController = TextEditingController();

  List<dynamic> lobList = [];
  List<dynamic> arrCollectionManager = [];
  List<dynamic> areaCollectionManager = [];
  List<dynamic> questionList = [];
  Map<String,dynamic> auditData = {};
  List<dynamic> answerList = [];
  List<String> auditCycleListAsString = [];

  List<dynamic> auditCycleList = [];
  String? selectedAuditCycle;
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
                  Text("Audit Form",
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
          Expanded(
              child: isLoading
                  ? Center(
                child: Loader(),
              )
                  : ListView(
                padding: const EdgeInsets.only(top: 8),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border:
                        Border.all(color: Colors.black, width: 0.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 46,
                          color: AppTheme.themeColor,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(headerName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("City",
                            "Enter City", cityNameController),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Yard",
                            "Enter Yard", yardController),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Lob",
                            "Enter lob", lobController),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Audit Cycle",
                            "Enter audit cycle", TextEditingController(text: widget.cycleDate)),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Audit Date",
                            "Enter date", auditDateController),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Product",
                            "Enter product", productController),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Yard Name",
                            "Enter yard name", yardNameController),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                                child: TextFieldWidgetNew(
                                    "Yard Manager",
                                    "Enter Manager",
                                    agencyManagerNameController),
                                flex: 1),
                            Expanded(
                                child: TextFieldWidgetNew(
                                    "Yard Phone",
                                    "Enter Number",
                                    agencyPhoneController),
                                flex: 1),
                          ],
                        ),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Yard Address",
                            "Enter yard address", yardAddressController),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                                child: TextFieldWidgetNew(
                                    "Branch Name",
                                    "Enter Name",
                                    branchNameController),
                                flex: 1),
                            Expanded(
                                child: TextFieldWidgetNew(
                                    "City",
                                    "Enter city",
                                    branchCityNameController),
                                flex: 1),
                          ],
                        ),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Location",
                            "Enter location", locationNameController),
                        SizedBox(height: 12),
                        TextFieldWidgetNew("Latitude, Longitude",
                            "Enter lat, long", latLongController),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border:
                        Border.all(color: Colors.black, width: 0.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 43,
                          color: AppTheme.themeColor,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text("Collection Manager",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),

                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: selectedManageList.length,
                            itemBuilder: (BuildContext context,int pos)

                            {
                              nationalManagerController = TextEditingController(text: selectedManageList[pos]['ncmname'],);
                              zonalManagerController = TextEditingController(text: selectedManageList[pos]['zcmname'],);
                              regionalManagerController = TextEditingController(text: selectedManageList[pos]['rcmname'],);
                              areaCollManagerController = TextEditingController(text: areaCollectionManager[pos]['name'],);
                              managerEmpCodeController = TextEditingController(text: selectedManageList[pos]['emp_id'].toString(),);
                              return Column(
                                children: [


                                  Container(
                                    height: 39,
                                    color: Colors.blue.withOpacity(0.3),
                                    child: Row(
                                      children: [


                                        SizedBox(width: 10),
                                        Text(selectedManageList[pos]['name'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 12),


                                  TextFieldWidgetNew("Manager Emp Code",
                                      "-", managerEmpCodeController),

                                  SizedBox(height: 12),


                                  TextFieldWidgetNew("Area Collection Manager",
                                      "-", areaCollManagerController),

                                  SizedBox(height: 12),

                                  TextFieldWidgetNew("Regional Collection Manager",
                                      "-", regionalManagerController),
                                  SizedBox(height: 12),

                                  TextFieldWidgetNew("Zonal Collection Manager",
                                      "-", zonalManagerController),
                                  SizedBox(height: 12),

                                  TextFieldWidgetNew("National Collection Manager",
                                      "-", nationalManagerController),
                                  SizedBox(height: 12),

                                ],
                              );
                            }



                        )


                      ],
                    ),
                  ),
                  SizedBox(height: 18),




                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        border:
                        Border.all(color: Colors.black, width: 0.7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 43,
                          color: AppTheme.themeColor,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text("Audit",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        ListView.builder(
                            itemCount: arrParameterList.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int pos) {
                              return Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Card(
                                      elevation: 3,
                                      color: Colors.white,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                               arrParameterList[pos]['parameter'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.blue,
                                                )),
                                            SizedBox(height: 5),
                                            ListView.builder(
                                                itemCount:arrParameterList[pos]['subparameter'].length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                scrollDirection:
                                                Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {





                                                  return Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            4),
                                                        child: Text(
                                                           arrParameterList[pos]['subparameter'][index]['sub_parameter'],
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color: Colors
                                                                  .black,
                                                            )),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              // width: 80,
                                                              height: 40,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  4),
                                                              padding: EdgeInsets
                                                                  .all(8),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      10),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                      0.5)),
                                                              child: Text(arrParameterList[pos]['subparameter'][index]['option_selected'],

                                                              ),


                                                            ),
                                                          ),


                                                          Container(
                                                            width: 80,
                                                            height: 32,
                                                            margin: EdgeInsets.symmetric(horizontal: 2),
                                                            color:Colors.cyan,
                                                            child: Center(
                                                              child:Text(
                                                                  arrParameterList[pos]['subparameter'][index]['score'],
                                                                  style: TextStyle(
                                                                    fontSize: 12.5,
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    color: Colors.white,
                                                                  )),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: 10),
                                                      Container(
                                                        // height: 41,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            4),
                                                        child: TextFormField(
                                                            style: const TextStyle(
                                                              fontSize:
                                                              13.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              color: Color(
                                                                  0xFF707070),
                                                            ),
                                                            controller: TextEditingController(text: arrParameterList[pos]['subparameter'][index]['remark']),
                                                            maxLines: 3,
                                                            decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10.0),
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                      Colors.black,
                                                                      width: 0.5),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0), borderSide: BorderSide(color: Colors.black, width: 0.5)),
                                                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0), borderSide: BorderSide(color: Colors.red, width: 0.5)),
                                                                border: InputBorder.none,
                                                                contentPadding: EdgeInsets.fromLTRB(7.0, 7.0, 5, 8),
                                                                //prefixIcon: fieldIC,
                                                                hintText: "Enter Remark here",
                                                                hintStyle: TextStyle(
                                                                  fontSize:
                                                                  12,
                                                                  fontWeight:
                                                                  FontWeight.w500,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(0.7),
                                                                )),),
                                                      ),
                                                      SizedBox(
                                                          height: 15),
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          Card(
                                                            elevation: 4,
                                                            shadowColor:
                                                            Colors
                                                                .grey,
                                                            shape:
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                            ),
                                                            child:
                                                            Container(
                                                              height: 46,
                                                              child:
                                                              ElevatedButton(
                                                                style: ButtonStyle(
                                                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                                                    // background
                                                                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF93A6A2)),
                                                                    // fore
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(6.0),
                                                                    ))),
                                                                onPressed:
                                                                    () {
                                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtifactScreen(sheetID,arrParameterList[pos]["id"].toString(),arrParameterList[pos]["subparameter"][index]["id"].toString(),"1456")));

                                                                    },
                                                                child:
                                                                const Text(
                                                                  'Show Artifact',
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    15.5,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                    color:
                                                                    Colors.black,
                                                                  ),
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(
                                                              width: 8),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: 22),
                                                    ],
                                                  );
                                                })
                                          ],
                                        ),
                                      )),
                                  SizedBox(height: 17),
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 14),
                  Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                    margin: EdgeInsets.symmetric(horizontal: 17),
                    decoration: BoxDecoration(
                        color: Color(0xFFFF5100),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Scorable:',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '100',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Scored:',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              double.parse(totalScore).toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Scored%:',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              double.parse(totalScore).toStringAsFixed(2)+'%',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Grade:',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              finalGrade,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                ],
              ))
        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewAuditData(context);
  }
  viewAuditData(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "audit_id":widget.auditID
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPIWithHeader('audit_sheet_edit', data, context);
    var responseJSON = json.decode(response.body);
    auditData = responseJSON['data'];
    cityNameController = TextEditingController(text:responseJSON['data']['audit_details']['city']);
    lobController = TextEditingController(text:responseJSON['data']['audit_details']['lob']);
     auditDateController = TextEditingController(text:responseJSON['data']['audit_details']['audit_date_by_aud']);
    productController = TextEditingController(text:widget.productName);
    agencyManagerNameController = TextEditingController(text:responseJSON['data']['audit_details']['agency_manager']);
    agencyPhoneController = TextEditingController(text:responseJSON['data']['audit_details']['phone']);
    branchCityNameController = TextEditingController(text:responseJSON['data']['audit_details']['city']);
    locationNameController = TextEditingController(text:responseJSON['data']['audit_details']['location']);
    yardAddressController = TextEditingController(text:responseJSON['data']['audit_details']['address']);
    String latLong = responseJSON['data']['audit_details']['latitude'] + "," + responseJSON['data']['audit_details']['longitude'];
    latLongController = TextEditingController(text:latLong);
    agencyID = responseJSON['data']['audit_details']['agency_id'].toString();
    yardID = responseJSON['data']['audit_details']['yard_id'].toString();
    productID = responseJSON['data']['audit_details']['product_id'].toString();
    auditData=responseJSON["data"]["audit_details"];
    arrParameterList = responseJSON['data']['sheet_details']['parameter'];
    //arrSubParameterList = responseJSON['data']['sheet_details']['parameter']['subparameter'];
    headerName = responseJSON['data']['sheet_details']['name'];
    sheetID=responseJSON["data"]["audit_details"]["qm_sheet_id"].toString();
    print(responseJSON);
    if (responseJSON['status'] == 1) {
      fetchManagerDataRecovery();
      //fetchAuditCycle();
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);

    } else {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }
    setState(() {
      isLoading=false;
    });

    // completedAuditList=responseJSON["data"];
    setState(() {

    });

  }
  fetchManagerDataRecovery() async {


    APIDialog.showAlertDialog(context, "Please wait...");
    String id = '';
    if (widget.auditType == "repo_yard"){
      id = yardID;
    }else{
      id = agencyID;
    }
    var requestModel = {
      "type": widget.auditType,
      "id": id,
      "product_id": productID
    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPIWithHeader('renderBranch', requestModel, context);

    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    arrCollectionManager = responseJSON["data"]["managers_data"]['collection_manager'];
    areaCollectionManager = responseJSON["data"]["managers_data"]['area_collection_manager'];

    if (widget.auditType == "repo_yard") {

      yardController = TextEditingController(text:responseJSON['data']['yard']['name']);
      yardNameController = TextEditingController(text:responseJSON['data']['yard']['name']);

      branchNameController =
          TextEditingController(text:responseJSON['data']['branch_detail']['name']);

    } else {
      yardController = TextEditingController(text:responseJSON['data']['agency']['name']);
      yardNameController = TextEditingController(text:responseJSON['data']['agency']['name']);
      branchNameController =
          TextEditingController(text:responseJSON['data']['branch_detail']['name']);
    }
    List<String> managerIDs=auditData["collection_manager_id"].toString().split(",");


    print("MANAGER IDS");
    print(managerIDs.toString());



    for(int i=0;i<arrCollectionManager.length;i++)
    {

      for(int j=0;j<managerIDs.length;j++)
      {

        if(managerIDs[j]==arrCollectionManager[i]["id"].toString())
        {
         // managerListAsString.add(managerList[i]["name"]);
          selectedManageList.add(arrCollectionManager[i]);

        }



      }



    }

    setState(() {});
  }
  // fetchAuditCycle() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var requestModel = {"qm_sheet_id": widget.sheetID};
  //
  //   print(requestModel);
  //
  //   ApiBaseHelper helper = ApiBaseHelper();
  //   var response =
  //   await helper.postAPIWithHeader('audit_sheet', requestModel, context);
  //   setState(() {
  //     isLoading = false;
  //   });
  //   var responseJSON = json.decode(response.body);
  //
  //
  //   auditCycleList = responseJSON["data"]["cycle"];
  //
  //
  //   for(int i=0;i<auditCycleList.length;i++)
  //   {
  //     if(auditCycleList[i]["id"].toString()==auditData["audit_cycle_id"].toString())
  //     {
  //       selectedAuditCycle=auditCycleList[i]["name"];
  //       break;
  //     }
  //   }
  //
  //   print("Hello cycle $selectedAuditCycle");
  //   setState(() {});
  // }
}
