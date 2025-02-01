import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_tester_app/core/constants/app_constants.dart';
import 'package:permission_tester_app/features/camera/presentation/cubit/camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState()) {
    _init();
  }

  Future<void> _init() async {
    emit(state.copyWith(isLoading: true));
    final cameras = await availableCameras();
    emit(state.copyWith(
      cameras: cameras,
      isLoading: false,
    ));
    checkPermission();
  }

  Future<void> checkPermission() async {
    final status = await Permission.camera.status;
    _handlePermissionStatus(status);
  }

  Future<void> requestPermission() async {
    final status = await Permission.camera.request();
    _handlePermissionStatus(status);
  }

  void _handlePermissionStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        emit(state.copyWith(
          permissionStatus: CameraPermissionStatus.granted,
          errorMessage: null,
        ));
        _initializeCamera();
        break;
      case PermissionStatus.denied:
        emit(state.copyWith(
          permissionStatus: CameraPermissionStatus.denied,
          errorMessage: AppConstants.cameraPermissionDenied,
        ));
        break;
      case PermissionStatus.permanentlyDenied:
        emit(state.copyWith(
          permissionStatus: CameraPermissionStatus.permanentlyDenied,
          errorMessage: AppConstants.cameraPermissionPermanentlyDenied,
        ));
        break;
      default:
        break;
    }
  }

  Future<void> _initializeCamera() async {
    if (state.cameras.isEmpty) return;

    final controller = CameraController(
      state.cameras[0],
      ResolutionPreset.max,
    );

    try {
      await controller.initialize();
      emit(state.copyWith(controller: controller));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to initialize camera: ${e.toString()}',
      ));
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