import 'package:examen_seekoo/presentation/bloc/blocs.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasources_imp/datasources_imp.dart';
import '../../data/datasources_locales/database_helper/database_local_data_source_impl.dart';
import '../../data/repositories_impl/databse_local_repositorie_impl/databse_local_repositorie_impl.dart';
import '../../data/repositories_impl/usuario_repository_impl/usuario_repository_impl.dart';
import '../../domain/data_sources/data_sources.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/user_cases/user_cases.dart';

//! Al borrar no se Actualiza la lista principal
GetIt locator = GetIt.instance;
void setupLocator() {
  //* Datasources
  locator.registerLazySingleton<UsuarioDataSource>(() => UsuarioDataSourceImpl(
      databaseHelper: locator<DatabaseLocalDataSourceImpl>()));

  locator.registerLazySingleton<DatabaseLocalDataSource>(
      () => locator<DatabaseLocalDataSourceImpl>());

  //* Repositories
  locator.registerLazySingleton<UsuarioRepository>(() =>
      UsuarioRepositoryImpl(usuarioDataSource: locator<UsuarioDataSource>()));

  locator.registerLazySingleton<DatabaseLocalRepository>(() =>
      DatabaseLocalRepositoryImpl(
          databaseLocalDataSource: locator<DatabaseLocalDataSource>()));

  //* UserCases
  locator.registerLazySingleton<GetUsuariosUserCase>(() =>
      GetUsuariosUserCaseImpl(usuarioRepository: locator<UsuarioRepository>()));

  locator.registerLazySingleton<DelTaskUserCase>(() => DelTaskUserCaseImpl(
      databaseLocalRepository: locator<DatabaseLocalRepository>()));

  locator.registerLazySingleton<InsertTaskUserCase>(() =>
      InsertTaskUserCaseImpl(
          databaseLocalRepository: locator<DatabaseLocalRepository>()));

  locator.registerLazySingleton<UpdateTaskUserCase>(() =>
      UpdateTaskUserCaseImpl(
          databaseLocalRepository: locator<DatabaseLocalRepository>()));

  //* Cubits
  locator.registerLazySingleton<TareasUsuarioCubit>(
    () => TareasUsuarioCubit(),
  );

  locator.registerLazySingleton<TaskCompletedCubit>(() => TaskCompletedCubit());

  locator.registerLazySingleton<UpdateTaskCubit>(
      () => UpdateTaskCubit(updateTaskUserCase: locator<UpdateTaskUserCase>()));

  //* Services helpers etc
  locator.registerLazySingleton<DatabaseLocalDataSourceImpl>(
      () => DatabaseLocalDataSourceImpl(database: locator<Database>()));

  //* Blocs
  locator.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      getUsuariosUserCase: locator<GetUsuariosUserCase>(),
      delTaskUserCase: locator<DelTaskUserCase>(),
      insertTaskUserCase: locator<InsertTaskUserCase>(),
      deleteTaskRecibe: locator<TareasUsuarioCubit>().streamerNewTask,
      updateTaskRecibe: locator<UpdateTaskCubit>().streamerUpdateTask,
      newTaskSendCallBack:
          locator<TareasUsuarioCubit>().addTareaUsuarioCallback,
    ),
  );

  //? uso de locator.registerLazySingletonAsync para inicializar la base de datos
  locator.registerLazySingletonAsync<Database>(() async {
    Future createDB(Database db, int version) async {
      const userTable = '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        username TEXT,
        email TEXT,
        phone TEXT,
        website TEXT,
        street TEXT,
        suite TEXT,
        city TEXT,
        zipcode TEXT,
        lat TEXT,
        lng TEXT,
        company_name TEXT,
        company_catchPhrase TEXT,
        company_bs TEXT
      )
    ''';
      const taskTable = '''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        title TEXT,
        completed INTEGER,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''';

      await db.execute(userTable);
      await db.execute(taskTable);
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "app_database.db");

    return await openDatabase(path, version: 1, onCreate: createDB);
  });
}
