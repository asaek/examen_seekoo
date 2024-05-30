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
