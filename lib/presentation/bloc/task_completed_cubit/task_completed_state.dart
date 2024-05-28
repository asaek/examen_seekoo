part of 'task_completed_cubit.dart';

sealed class TaskCompletedState extends Equatable {
  const TaskCompletedState();

  @override
  List<Object> get props => [];
}

final class TaskCompletedInitial extends TaskCompletedState {}
