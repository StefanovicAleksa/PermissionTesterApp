import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_tester_app/features/dashboard/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
}