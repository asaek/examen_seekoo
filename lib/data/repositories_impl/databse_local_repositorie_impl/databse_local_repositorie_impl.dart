import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

class DatabaseLocalRepositoryImpl implements DatabaseLocalRepository {
  final DatabaseLocalDataSource databaseLocalDataSource;

  DatabaseLocalRepositoryImpl({required this.databaseLocalDataSource});

  @override
  Future<bool> deleteData(String id) async {
    return await databaseLocalDataSource.deleteTask(id);
  }

  @override
  Future<int> insertData(TareaEntity task) async {
    return await databaseLocalDataSource.insertTask(task);
  }

  @override
  Future<bool> updateData(
      {required String table, required TareaEntity task}) async {
    return await databaseLocalDataSource.updateTask(table: table, task: task);
  }
}
