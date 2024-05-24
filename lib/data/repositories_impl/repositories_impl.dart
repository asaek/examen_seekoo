import 'package:examen_seekoo/domain/entities/entities.dart';

import '../../domain/data_sources/usuario_datasource/usuario_datasource.dart';
import '../../domain/repositories/repositories.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final UsuarioDataSource usuarioDataSource;

  UsuarioRepositoryImpl({required this.usuarioDataSource});

  @override
  Future<List<UsuarioEntitie>> getUsuarios() => usuarioDataSource.getUsuarios();
}
