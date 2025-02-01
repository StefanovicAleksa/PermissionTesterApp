import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';

enum CameraPermissionStatus {
  initial,
  granted,
  denied,
  permanentlyDenied,
}

class CameraState extends Equatable {
  final CameraPermissionStatus permissionStatus;
  final bool isLoading;
  final String? errorMessage;
  final List<CameraDescription> cameras;
  final CameraController? controller;

  const CameraState({
    this.permissionStatus = CameraPermissionStatus.initial,
    this.isLoading = false,
    this.errorMessage,
    this.cameras = const [],
    this.controller,
  });

  CameraState copyWith({
    CameraPermissionStatus? permissionStatus,
    bool? isLoading,
    String? errorMessage,
    List<CameraDescription>? cameras,
    CameraController? controller,
  }) {
    return CameraState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      cameras: cameras ?? this.cameras,
      controller: controller ?? this.controller,
    );
  }

  @override
  List<Object?> get props => [
        permissionStatus,
        isLoading,
        errorMessage,
        cameras,
        controller,
      ];
}