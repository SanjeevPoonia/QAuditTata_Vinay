





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_theme.dart';

class DropDownWidget extends StatelessWidget
{
  Function onTap;
  String title;
  final String selectedValue;
  DropDownWidget(this.onTap,this.title,this.selectedValue);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              )),
        ),

        SizedBox(height: 2),

        GestureDetector(
          onTap: (){
            onTap();
          },
          child: Container(
            height: 41,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black,width: 0.5)
            ),

            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(selectedValue,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        )),
                  ),
                ),




                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text("Select",
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.themeColor,
                      )),
                ),


              ],
            ),

          ),
        )


      ],
    );
  }

}
