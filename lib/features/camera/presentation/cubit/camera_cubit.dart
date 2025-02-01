import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_tester_app/features/camera/presentation/cubit/camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(status: CameraStatus.loading));
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        emit(state.copyWith(
          status: CameraStatus.notAvailable,
          errorMessage: 'No cameras available',
        ));
        return;
      }
      
      emit(state.copyWith(
        cameras: cameras,
        status: CameraStatus.initial,
      ));
      
      await _initializeCamera();
    } catch (e) {
      emit(state.copyWith(
        status: CameraStatus.error,
        errorMessage: 'Failed to initialize camera: ${e.toString()}',
      ));
    }
  }

  Future<void> _initializeCamera() async {
    if (state.cameras.isEmpty) return;

    try {
      final controller = CameraController(
        state.cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();
      emit(state.copyWith(
        controller: controller,
        status: CameraStatus.ready,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CameraStatus.error,
        errorMessage: 'Failed to initialize camera: ${e.toString()}',
      ));
    }
  }

  Future<void> openSettings() async {
    if (Platform.isIOS) {
      const url = 'app-settings:';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } else if (Platform.isAndroid) {
      const url = 'package:com.android.settings';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    }
  }

  Future<String?> takePicture() async {
    try {
      if (state.controller == null || !state.controller!.value.isInitialized) {
        return null;
      }

      final XFile image = await state.controller!.takePicture();
      return image.path;
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to take picture: ${e.toString()}',
      ));
      return null;
    }
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    return super.close();
  }
}