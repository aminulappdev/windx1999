import 'package:flutter/material.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';

import 'package:windx1999/app/res/common_widgets/custom_rectangle_buttom.dart';
import 'package:windx1999/app/res/common_widgets/image_container.dart';
import 'package:windx1999/app/res/common_widgets/search_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool isNotFound = false;

   @override
     void initState() {
    changeStatus();
    super.initState();
  }

  Future<void> changeStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    isNotFound = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(),
            heightBox50,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent search history',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    
                  },
                  
                  child: Text('Clear all',style: TextStyle(color: Colors.blue),))
              ],
            ),
            heightBox12,
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(AssetsPath.blackGirl),
                    ),
                    title: Text(
                      'Aminul islam',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Aminul islam messeage',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: SizedBox(
                      width: 110,
                      child: Row(
                        children: [
                          CustomRectangleButton(
                              bgColor: Color(0xff6CC7FE),
                              height: 36,
                              width: 80,
                              radiusSize: 12,
                              textColor: Colors.white,
                              textSize: 12,
                              text: 'Follow',
                              ontap: () {}),
                              Icon(Icons.more_vert,color: Colors.white,size: 30,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ) ,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageContainer(imagePath: AssetsPath.search, height: 80, width: 95, borderRadius: 10, borderColor: Colors.transparent),
                Text('No results for”Shimul”',style: TextStyle(fontSize: 20,color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('We couldn’t find any matching results. Please refine your search orcheck back later.”',style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
