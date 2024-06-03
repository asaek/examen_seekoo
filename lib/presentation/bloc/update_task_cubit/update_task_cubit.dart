import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/user_cases/user_cases.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  final UpdateTaskUserCase updateTaskUserCase;
  final StreamController<TareaEntity> _streamController =
      StreamController<TareaEntity>.broadcast();

  UpdateTaskCubit({
    required this.updateTaskUserCase,
  }) : super(const UpdateTaskState(tareaEntity: null));

  Stream<TareaEntity> get streamerUpdateTask => _streamController.stream;

  void updateTaskSelected(TareaEntity tareaEntity) {
    emit(state.copyWith(tareaEntity: tareaEntity));
  }

  void updateTask({required String table, required TareaEntity task}) async {
    final bool isUpdated =
        await updateTaskUserCase.updateTask(table: table, task: task);

    //! no se esta comunicando con el bloc no con la lista de tareas
    //! se podria hacer que el blco escuche a los cubits ya sea con un stream
    //! y que el solo actualice la lista con la nueva listas

    if (isUpdated) {
      emit(state.copyWith(tareaEntity: null));
      _streamController.add(task);
    }
  }
}
