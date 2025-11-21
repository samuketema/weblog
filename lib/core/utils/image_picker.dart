import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async{
 try {
   final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery) ;
 if (pickedImage == null) {
   return null;
 } 
 return File( pickedImage.path);
 } catch (e) {
   return null; 
 }
} 