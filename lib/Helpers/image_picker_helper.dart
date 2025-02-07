import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(
    {bool isGallery = false, bool isNavigateToHome = false}) async {
  ImagePicker _picker = ImagePicker();
  var image = await _picker.pickImage(
    source: isGallery ? ImageSource.gallery : ImageSource.camera,
    preferredCameraDevice: CameraDevice.front,
    maxWidth: 1024,
  );
  if (image != null) {
    return image;
  }
  return null;
}

/// For Multi Image
Future<List<XFile>?> pickMultiImage() async {
  ImagePicker _picker = ImagePicker();
  var image = await _picker.pickMultiImage(
    maxHeight: 1024,
    maxWidth: 1024,
  );
  if (image != null) {
    return image;
  } else {
    return null;
  }
}


///CropImage
// Future cropImage(context, XFile? image) async {
//   var croppedFile;
//   if (image != null) {
//     croppedFile = await ImageCropper().cropImage(
//       sourcePath: image.path,
//       compressFormat: ImageCompressFormat.jpg,
//       compressQuality: 100,
//       uiSettings: [
//         AndroidUiSettings(
//             toolbarTitle: 'Cropper',
//             toolbarColor: Colors.blue,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false),
//         IOSUiSettings(
//           title: 'Cropper',
//         ),
//         WebUiSettings(
//           context: context,
//           presentStyle: CropperPresentStyle.dialog,
//           boundary: const CroppieBoundary(
//             width: 520,
//             height: 520,
//           ),
//           viewPort:
//               const CroppieViewPort(width: 480, height: 480, type: 'circle'),
//           enableExif: true,
//           enableZoom: true,
//           showZoomer: true,
//         ),
//       ],
//     );
//   }
//   return croppedFile ?? null;
// }
