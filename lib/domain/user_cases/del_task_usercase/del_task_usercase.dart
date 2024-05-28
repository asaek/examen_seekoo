import '../../repositories/repositories.dart';

sealed class DelTaskUserCase {
  // Future<bool> insertData(String table, Map<String, dynamic> data);
  // Future<bool> updateData(String table, Map<String, dynamic> data);
  Future<bool> deleteTask(String id);
}

class DelTaskUserCaseImpl implements DelTaskUserCase {
  final DatabaseLocalRepository databaseLocalRepository;

  DelTaskUserCaseImpl({required this.databaseLocalRepository});

  @override
  Future<bool> deleteTask(String id) async {
    return await databaseLocalRepository.deleteData(id);
  }
}
