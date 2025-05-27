// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class ImageService {
//   final ImagePicker _picker = ImagePicker();

//   Future<File?> pickImage({required ImageSource source}) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//         imageQuality: 80,
//       );

//       if (pickedFile != null) {
//         return File(pickedFile.path);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//       return null;
//     }
//   }
// }
