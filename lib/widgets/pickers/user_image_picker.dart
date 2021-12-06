import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(XFile pickedImage) imagePickFn;

  const UserImagePicker(this.imagePickFn);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;
  void _pickImage() async {
    final _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = XFile(image!.path);
    });
    widget.imagePickFn(XFile(image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
        ),
      ],
    );
  }
}


// Column(
//       children: [
//         InkWell(
//           onTap: _pickImage,
//           child: CircleAvatar(
//             backgroundColor: Colors.black,
//             radius: 40.0,
//             child: CircleAvatar(
//               radius: 38.0,
//               child: ClipOval(
//                 child: (_pickedImage == null)
//                     ? const Icon(Icons.edit)
//                     : Image.file(File(_pickedImage!.path)),
//               ),
//               backgroundColor: Colors.white,
//             ),
//           ),
//         )
//       ],
//     );