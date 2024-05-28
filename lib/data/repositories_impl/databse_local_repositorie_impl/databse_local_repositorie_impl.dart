import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

class DatabaseLocalRepositoryImpl implements DatabaseLocalRepository {
  final DatabaseLocalDataSource databaseLocalDataSource;

  DatabaseLocalRepositoryImpl({required this.databaseLocalDataSource});

  @override
  Future<bool> deleteData(String id) async {
    return await databaseLocalDataSource.deleteData(id);
  }

  @override
  Future<int> insertData(TareaEntity task) async {
    return await databaseLocalDataSource.insertData(task);
  }

  @override
  Future<bool> updateData(String table, Map<String, dynamic> data) async {
    return await databaseLocalDataSource.updateData(table, data);
  }
}
