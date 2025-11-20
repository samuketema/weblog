import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:weblog/blog/presentation/widgets/blog_editor.dart';
import 'package:weblog/core/theme/app_pallete.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final  titleController = TextEditingController();
  final  contentController = TextEditingController();
  List selelctedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DottedBorder(
                
                options: RoundedRectDottedBorderOptions(
                  radius:Radius.circular(10),
                  color: AppPallete.borderColor,
                  strokeCap: StrokeCap.round,
                  dashPattern: [10,4]
                ),
                child: Container(
                  color: AppPallete.backgroundColor,
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_open),
                      SizedBox(height: 15),
                      Text("Select your Image", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology','Business','Programming','Entertainment',
                  ].map((e)=>Padding(
                    padding: EdgeInsets.all(5),
                    child: Chip(label: Text(e),
                    side: BorderSide(
                      color: AppPallete.borderColor
                    ),),
                  ),
                  ).toList(),
                ), 
              ),
              SizedBox(height: 10,),
              BlogEditor(controller: titleController, hint: "Blog title"),
              SizedBox(height: 10,),
              BlogEditor(controller: contentController, hint: "Blog content")
            ],
             
          ),
        ),
      ),
    );
  }
}
