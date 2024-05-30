import '../../entities/entities.dart';

abstract class DatabaseLocalDataSource {
  Future<int> insertTask(TareaEntity task);
  Future<bool> updateTask({required String table, required TareaEntity task});
  Future<bool> deleteTask(String id);
}
