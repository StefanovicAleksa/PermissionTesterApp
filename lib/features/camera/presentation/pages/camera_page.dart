import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_tester_app/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:permission_tester_app/features/camera/presentation/cubit/camera_state.dart';
import 'package:permission_tester_app/features/camera/presentation/widgets/camera_preview_widget.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CameraCubit(),
      child: const CameraView(),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Test'),
      ),
      body: BlocConsumer<CameraCubit, CameraState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case CameraStatus.loading:
              return const Center(child: CircularProgressIndicator());
              
            case CameraStatus.ready:
              if (state.controller != null && 
                  state.controller!.value.isInitialized) {
                return CameraPreviewWidget(
                  controller: state.controller!,
                  onTakePicture: () async {
                    final imagePath = await context
                        .read<CameraCubit>()
                        .takePicture();
                    if (imagePath != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Image saved to: $imagePath'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());

            case CameraStatus.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Camera access is not available. Please check your settings.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context
                            .read<CameraCubit>()
                            .openSettings(),
                        icon: const Icon(Icons.settings),
                        label: const Text('Open Settings'),
                      ),
                    ],
                  ),
                ),
              );

            case CameraStatus.notAvailable:
              return const Center(
                child: Text('No camera available on this device'),
              );

            case CameraStatus.initial:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        size: 64,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Please grant camera access in your device settings',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context
                            .read<CameraCubit>()
                            .openSettings(),
                        icon: const Icon(Icons.settings),
                        label: const Text('Open Settings'),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}