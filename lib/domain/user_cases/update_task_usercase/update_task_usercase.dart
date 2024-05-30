import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

sealed class UpdateTaskUserCase {
  Future<bool> updateTask({required String table, required TareaEntity task});
}

class UpdateTaskUserCaseImpl implements UpdateTaskUserCase {
  final DatabaseLocalRepository databaseLocalRepository;

  UpdateTaskUserCaseImpl({required this.databaseLocalRepository});

  @override
  Future<bool> updateTask(
      {required String table, required TareaEntity task}) async {
    return await databaseLocalRepository.updateData(table: table, task: task);
  }
}
