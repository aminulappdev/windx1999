import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windx1999/app/modules/homepage/widgets/bottonSheet_details_row.dart';


class ButtonSheetDetailsScreen extends StatefulWidget {
  const ButtonSheetDetailsScreen(
      {super.key, required this.buttonSheetDetailsList});

  final List<Map<String, dynamic>> buttonSheetDetailsList;

  @override
  State<ButtonSheetDetailsScreen> createState() =>
      _ButtonSheetDetailsScreenState();
}

class _ButtonSheetDetailsScreenState extends State<ButtonSheetDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(0.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true, 
                  physics: NeverScrollableScrollPhysics(), 
                  itemCount: widget.buttonSheetDetailsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonSheetDetailsRow(
                        icon: widget.buttonSheetDetailsList[index]['icon'],
                        name: widget.buttonSheetDetailsList[index]['name'],
                        ontap: widget.buttonSheetDetailsList[index]['ontap']
                      ),
                    );
                  },
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
