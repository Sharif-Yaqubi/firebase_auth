import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImageProvider extends ChangeNotifier {
  final picker = ImagePicker();
  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  Future<void> packImage() async {
    final XFile? selectedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedFile != null) {
      _imageFile = selectedFile;
      notifyListeners();
    }
  }
}