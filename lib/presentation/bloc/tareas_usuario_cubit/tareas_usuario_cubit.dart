import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

part 'tareas_usuario_state.dart';

typedef BorrarTarea = void Function(TareaEntity value);

class TareasUsuarioCubit extends Cubit<TareasUsuarioState> {
  final BorrarTarea? borrarTarea;

  TareasUsuarioCubit({required this.borrarTarea})
      : super(const TareasUsuarioState(tareas: null));

  void setTareasUsuario(List<TareaEntity>? tareas) {
    emit(state.copyWith(tareas: tareas));
  }

  // void addTareaUsuario(TareaEntity tarea) {
  //   final List<TareaEntity> tareas = state.tareas ?? [];
  //   tareas.add(tarea);
  //   emit(state.copyWith(tareas: tareas));
  // }

  void removeTareaUsuario(TareaEntity tarea) {
    List<TareaEntity> tareas = List<TareaEntity>.from(state.tareas!);

    tareas.remove(tarea);
    borrarTarea!.call(tarea);
    emit(state.copyWith(tareas: tareas));
  }

  // void updateTareaUsuario(TareaEntity tarea) {
  //   final List<TareaEntity> tareas = state.tareas ?? [];
  //   final index = tareas.indexWhere((element) => element.id == tarea.id);
  //   tareas[index] = tarea;
  //   emit(state.copyWith(tareas: tareas));
  // }
}
