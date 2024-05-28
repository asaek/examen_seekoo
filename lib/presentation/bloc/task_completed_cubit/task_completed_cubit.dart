import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_completed_state.dart';

class TaskCompletedCubit extends Cubit<TaskCompletedState> {
  TaskCompletedCubit() : super(TaskCompletedInitial());
}
