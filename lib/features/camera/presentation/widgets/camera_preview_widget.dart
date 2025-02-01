import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraController controller;
  final VoidCallback onTakePicture;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
    required this.onTakePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CameraPreview(controller),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton(
            onPressed: onTakePicture,
            child: const Icon(Icons.camera),
          ),
        ),
      ],
    );
  }
}