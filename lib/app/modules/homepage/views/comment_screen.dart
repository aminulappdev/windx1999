import 'package:flutter/material.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomAppBar(title: 'Comments'),
                      heightBox40,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(AssetsPath.blackGirl),
                          ),
                          widthBox8,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aminul',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                'Massalah sundor hoiche',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Reply..',
                                style: TextStyle(color: Colors.white),
                              ),
                              heightBox14,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(AssetsPath.blackGirl),
                                  ),
                                  widthBox8,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Aminul',
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        'Massalah sundor hoiche',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        'Reply..',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // This Expanded widget will take up the remaining space above the container
                Expanded(
                  child: SizedBox.shrink(),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 82,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffFFFFFF).withOpacity(0.32),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                           CircleAvatar(
                            radius: 18,
                                      backgroundImage: AssetImage(AssetsPath.blackGirl),
                                    ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                               
                                fillColor: Colors.transparent,
                                hintText: 'Writes a comment',
                                suffixIcon:  Icon(Icons.attach_file, color: Colors.black,),
                                contentPadding: EdgeInsets.all(10)
                              ),
                            ),
                          ),
                           Icon(Icons.send, color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
