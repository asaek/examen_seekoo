part of 'tareas_usuario_cubit.dart';

class TareasUsuarioState extends Equatable {
  final List<TareaEntity>? tareas;
  const TareasUsuarioState({required this.tareas});

  TareasUsuarioState copyWith({
    List<TareaEntity>? tareas,
  }) {
    return TareasUsuarioState(
      tareas: tareas,
    );
  }

  @override
  List<Object?> get props => [tareas];
}
