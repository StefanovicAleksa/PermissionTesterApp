import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';

enum CameraStatus {
  initial,
  loading,
  ready,
  error,
  notAvailable
}

class CameraState extends Equatable {
  final CameraStatus status;
  final String? errorMessage;
  final List<CameraDescription> cameras;
  final CameraController? controller;

  const CameraState({
    this.status = CameraStatus.initial,
    this.errorMessage,
    this.cameras = const [],
    this.controller,
  });

  CameraState copyWith({
    CameraStatus? status,
    String? errorMessage,
    List<CameraDescription>? cameras,
    CameraController? controller,
  }) {
    return CameraState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      cameras: cameras ?? this.cameras,
      controller: controller ?? this.controller,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        cameras,
        controller,
      ];
}