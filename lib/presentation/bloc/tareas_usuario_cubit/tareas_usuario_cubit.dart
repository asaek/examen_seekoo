import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

part 'tareas_usuario_state.dart';

class TareasUsuarioCubit extends Cubit<TareasUsuarioState> {
  final StreamController<TareaEntity> _deleteTaskController =
      StreamController<TareaEntity>.broadcast();

  TareasUsuarioCubit() : super(const TareasUsuarioState(tareas: null));

  Stream<TareaEntity> get streamerNewTask => _deleteTaskController.stream;

  void setTareasUsuario(List<TareaEntity>? tareas) {
    emit(state.copyWith(tareas: tareas));
  }

  void removeTareaUsuario(TareaEntity tarea) {
    List<TareaEntity> tareas = List<TareaEntity>.from(state.tareas!);
    tareas.remove(tarea);

    //* Se envia la tarea
    _deleteTaskController.add(tarea);
    emit(state.copyWith(tareas: tareas));
  }

  void addTareaUsuarioCallback(TareaEntity tarea) {
    List<TareaEntity> tareas = List<TareaEntity>.from(state.tareas!);
    tareas.add(tarea);

    emit(state.copyWith(tareas: tareas));
  }
}
