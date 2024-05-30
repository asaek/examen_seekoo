part of 'update_task_cubit.dart';

class UpdateTaskState extends Equatable {
  final TareaEntity? tareaEntity;
  const UpdateTaskState({
    required this.tareaEntity,
  });

  UpdateTaskState copyWith({
    required TareaEntity? tareaEntity,
  }) {
    return UpdateTaskState(
      tareaEntity: tareaEntity ?? this.tareaEntity,
    );
  }

  @override
  List<Object?> get props => [tareaEntity];
}
