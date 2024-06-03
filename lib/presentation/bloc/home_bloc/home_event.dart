part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetUsuarios extends HomeEvent {}

class NewTask extends HomeEvent {
  final TareaEntity newTask;

  const NewTask({required this.newTask});

  @override
  List<Object> get props => [newTask];
}

class DeleteTask extends HomeEvent {
  final TareaEntity tarea;

  const DeleteTask({required this.tarea});

  @override
  List<Object> get props => [tarea];
}

class UpdateTask extends HomeEvent {
  final TareaEntity tarea;

  const UpdateTask({required this.tarea});

  @override
  List<Object> get props => [tarea];
}
