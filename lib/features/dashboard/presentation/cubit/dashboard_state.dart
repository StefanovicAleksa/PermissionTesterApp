import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  
  const DashboardState({
    this.isLoading = false,
  });

  DashboardState copyWith({
    bool? isLoading,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isLoading];
}