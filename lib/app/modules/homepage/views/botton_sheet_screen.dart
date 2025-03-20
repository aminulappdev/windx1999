// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:windx1999/app/modules/homepage/widgets/bottonSheet_details_row.dart';
// import 'package:windx1999/app/res/custom_style/custom_size.dart';

// class ButtonSheetDetailsScreen extends StatefulWidget {
//   const ButtonSheetDetailsScreen({super.key, required this.buttonSheetDetailsList});

//   final List<Map<String,dynamic>> buttonSheetDetailsList;


//   @override
//   State<ButtonSheetDetailsScreen> createState() => _ButtonSheetDetailsScreenState();
// }

// class _ButtonSheetDetailsScreenState extends State<ButtonSheetDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(0.0),
//       child: Column(
//         children: [
//           Padding(
//             padding:
//                  EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w, bottom: 20.h),
//             child: Column(
//               children: [
//                 heightBox20,
//                 ButtonSheetDetailsRow(
//                   icon: Icons.bookmark,
//                   name: 'Save post',
//                   ontap: () {},
//                 ),
//                 heightBox20,
               
//                 ButtonSheetDetailsRow(
//                   icon: Icons.copy,
//                   name: 'Copy link',
//                   ontap: () {},
//                 ),
//                 heightBox20,
              
//                 ButtonSheetDetailsRow(
//                   icon: Icons.visibility_off,
//                   name: 'Hide post',
//                   ontap: () {},
//                 ),
//                 heightBox20,
//                 ButtonSheetDetailsRow(
//                   icon: Icons.person_remove,
//                   name: 'Unfollow',
//                   ontap: () {},
//                 ),
//                 heightBox20,
               
//                 ButtonSheetDetailsRow(
//                   icon: Icons.person_off,
//                   name: 'Block',
//                   ontap: () {},
//                 ),
//                 heightBox20,
              
//                 ButtonSheetDetailsRow(
//                   icon: Icons.smart_display_outlined,
//                   name: 'Report profile',
//                   ontap: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrinkwrap column size
              children: [
                ListView.builder(
                  shrinkWrap: true, // This allows ListView to take only the necessary space
                  physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
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
