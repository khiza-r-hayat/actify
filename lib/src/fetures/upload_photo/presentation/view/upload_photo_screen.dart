import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../constants/colors.dart';

class UploadPhotoScreen extends StatefulWidget {
  final bool isSupervisor;
  const UploadPhotoScreen({super.key, required this.isSupervisor});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  final baDescription =
      'Take a clear selfie of yourself with visible background of your location';

  final supervisorDescription =
      'Take a clear selfie of yourself with visible background of your location';

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  getImage() async {
    final camera = widget.isSupervisor ? CameraDevice.rear : CameraDevice.front;
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: camera);

    if (image != null) {
      imageFile = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Picture'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: imageFile == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 50),
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                widget.isSupervisor
                                    ? supervisorDescription
                                    : baDescription,
                                style: const TextStyle(
                                    color: Colors.black38, fontSize: 13)),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tap here to take ${widget.isSupervisor ? 'photo' : 'selfie'}',
                              style: const TextStyle(
                                  color: Colors.black12, fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                            widget.isSupervisor
                                ? supervisorDescription
                                : baDescription,
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 13)),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          constraints:
                              BoxConstraints(maxHeight: size.height * 0.7),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(imageFile!))),
                        ),
                      ],
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: primaryColor),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              child: const Center(
                  child: Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
