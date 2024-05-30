import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/user_cases/user_cases.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  final UpdateTaskUserCase updateTaskUserCase;
  UpdateTaskCubit({
    required this.updateTaskUserCase,
  }) : super(const UpdateTaskState(tareaEntity: null));

  void updateTaskSelected(TareaEntity tareaEntity) {
    emit(state.copyWith(tareaEntity: tareaEntity));
  }

  void updateTask({required String table, required TareaEntity task}) async {
    final bool isUpdated =
        await updateTaskUserCase.updateTask(table: table, task: task);
    print(isUpdated);
    if (isUpdated) {
      emit(state.copyWith(tareaEntity: null));
    }
  }
}

//! falta que actulice la lista de tareas ya que se actualiza 
//! la tarea pero no se actualiza la lista de tareas ni la 
//! ni la lista de tareas del usuarios