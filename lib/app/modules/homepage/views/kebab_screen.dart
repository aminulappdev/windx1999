import 'package:flutter/material.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class KebabScreen extends StatefulWidget {
  const KebabScreen({super.key});

  @override
  State<KebabScreen> createState() => _KebabScreenState();
}

class _KebabScreenState extends State<KebabScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20,bottom: 20),
            child: Column(
              children: [
                heightBox20,
                Row(
                  children: [
                    Icon(Icons.bookmark,size: 30,color: Colors.white,),
                    widthBox14,
                    Text('Save post',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)
                  ],
                ),
                heightBox12,
                Row(
                  children: [
                    Icon(Icons.bookmark,size: 30,color: Colors.white,),
                    widthBox14,
                    Text('Save post',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)
                  ],
                ),
                 heightBox12,
                Row(
                  children: [
                    Icon(Icons.bookmark,size: 30,color: Colors.white,),
                    widthBox14,
                    Text('Save post',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)
                  ],
                ),
                 heightBox12,
                Row(
                  children: [
                    Icon(Icons.bookmark,size: 30,color: Colors.white,),
                    widthBox14,
                    Text('Save post',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
