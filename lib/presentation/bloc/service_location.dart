import 'package:examen_seekoo/presentation/bloc/blocs.dart';
import 'package:get_it/get_it.dart';

import '../../config/database_helper/database_helper.dart';
import '../../data/datasources_imp/usuario_datasource_impl/usuario_datasource_impl.dart';
import '../../data/repositories_impl/repositories_impl.dart';
import '../../domain/data_sources/usuario_datasource/usuario_datasource.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/user_cases/user_cases.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  //* Datasources
  locator.registerLazySingleton<UsuarioDataSource>(
      () => UsuarioDataSourceImpl(databaseHelper: locator<DatabaseHelper>()));

  //* Repositories
  locator.registerLazySingleton<UsuarioRepository>(() =>
      UsuarioRepositoryImpl(usuarioDataSource: locator<UsuarioDataSource>()));

  //* UserCases
  locator.registerLazySingleton<GetUsuariosUserCase>(() =>
      GetUsuariosUserCaseImpl(usuarioRepository: locator<UsuarioRepository>()));

  //* Blocs
  locator.registerLazySingleton<HomeBloc>(
      () => HomeBloc(getUsuariosUserCase: locator<GetUsuariosUserCase>()));

  //* Cubits
  locator.registerLazySingleton<TareasUsuarioCubit>(() =>
      TareasUsuarioCubit(borrarTarea: locator<HomeBloc>().streamerBorrarTarea));

  //* Services helpers etc
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.init());
}
