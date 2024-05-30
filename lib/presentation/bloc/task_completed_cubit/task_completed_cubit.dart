import 'package:bloc/bloc.dart';

class TaskCompletedCubit extends Cubit<bool> {
  TaskCompletedCubit() : super(false);

  void toggleTaskCompleted() => emit(!state);

  void setTaskCompleted() => emit(true);

  void resetTaskCompleted() => emit(false);
}
