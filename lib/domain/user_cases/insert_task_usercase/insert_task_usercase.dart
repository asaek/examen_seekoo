import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

sealed class InsertTaskUserCase {
  Future<int> insertTask(TareaEntity task);
}

class InsertTaskUserCaseImpl implements InsertTaskUserCase {
  final DatabaseLocalRepository databaseLocalRepository;

  InsertTaskUserCaseImpl({required this.databaseLocalRepository});

  @override
  Future<int> insertTask(TareaEntity task) async {
    return await databaseLocalRepository.insertData(task);
  }
}
