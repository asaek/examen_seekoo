import 'package:dio/dio.dart';
import 'package:examen_seekoo/data/models/models.dart';
import 'package:examen_seekoo/domain/entities/entities.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/data_sources/usuario_datasource/usuario_datasource.dart';
import '../../datasources_locales/database_helper/database_local_data_source_impl.dart';
import '../../mappers/usuario_mapper/usuario_mapper.dart';

class UsuarioDataSourceImpl extends UsuarioDataSource {
  final DatabaseLocalDataSourceImpl databaseHelper;

  UsuarioDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<UsuarioEntitie>> getUsuarios() async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      ),
    );
    final Database db = databaseHelper.database;

    try {
      //! Cargar de la base de datos local
      final List<Map<String, dynamic>> mapsUsuarios = await db.query('users');
      final List<Map<String, dynamic>> mapsTareas = await db.query('tasks');

      final List<UsuarioModel> usuariosBD =
          List.generate(mapsUsuarios.length, (i) {
        return toUsuarioModel(mapsUsuarios[i]);
      });

      final List<TareaModel> tareasBD = List.generate(mapsTareas.length, (i) {
        return toTareaModel(mapsTareas[i]);
      });

      for (UsuarioModel usuario in usuariosBD) {
        usuario.listaTareas =
            tareasBD.where((element) => element.userId == usuario.id).toList();
      }

      //! Si hay datos en la base de datos local
      if (usuariosBD.isNotEmpty) {
        return usuariosMapper(usuariosBD);
      }

      //! Si no hay datos en la base de datos local
      final Response<dynamic> response = await dio.get('/users');

      if (response.statusCode == 200) {
        final List<UsuarioModel> usuarios = (response.data as List)
            .map((json) => UsuarioModel.fromJson(json))
            .toList();

        for (UsuarioModel usuario in usuarios) {
          final Response<dynamic> responseTareas =
              await dio.get('/todos?userId=${usuario.id}');

          if (responseTareas.statusCode == 200) {
            final List<TareaModel> tareas = (responseTareas.data as List)
                .map((json) => TareaModel.fromJson(json))
                .toList();

            usuario.listaTareas = tareas;
          } else {
            return [
              UsuarioEntitie(
                id: null,
                name: null,
                username: null,
                email: null,
                address: null,
                phone: null,
                website: null,
                company: null,
                listaTareas: null,
                error: 'Error al obtener las tareas.',
              )
            ];
          }
        }

        //! Guardar en la base de datos local
        for (UsuarioModel usuario in usuarios) {
          await db.insert('users', toMapUsuario(usuario: usuario),
              conflictAlgorithm: ConflictAlgorithm.replace);
          if (usuario.listaTareas != null) {
            for (TareaModel tarea in usuario.listaTareas!) {
              await db.insert('tasks', toMapTarea(tarea: tarea),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
        }

        final List<UsuarioEntitie> usuariosEntitie = usuariosMapper(usuarios);

        return usuariosEntitie;
      } else {
        return [
          UsuarioEntitie(
            id: null,
            name: null,
            username: null,
            email: null,
            address: null,
            phone: null,
            website: null,
            company: null,
            listaTareas: null,
            error: 'Error al obtener los usuarios.',
          )
        ];
      }
    } catch (e) {
      return [
        UsuarioEntitie(
          id: null,
          name: null,
          username: null,
          email: null,
          address: null,
          phone: null,
          website: null,
          company: null,
          listaTareas: null,
          error: 'Error Algo fallo: ${e.toString()} ',
        )
      ];
    }
  }
}

Map<String, Object?> toMapUsuario({required UsuarioModel usuario}) {
  return {
    'id': usuario.id,
    'name': usuario.name,
    'username': usuario.username,
    'email': usuario.email,
    'phone': usuario.phone,
    'website': usuario.website,
    'street': usuario.address.street,
    'suite': usuario.address.suite,
    'city': usuario.address.city,
    'zipcode': usuario.address.zipcode,
    'lat': usuario.address.geo.lat,
    'lng': usuario.address.geo.lng,
    'company_name': usuario.company.name,
    'company_catchPhrase': usuario.company.catchPhrase,
    'company_bs': usuario.company.bs,
  };
}

Map<String, Object?> toMapTarea({required TareaModel tarea}) {
  return {
    'id': tarea.id,
    'userId': tarea.userId,
    'title': tarea.title,
    'completed': tarea.completed,
  };
}

UsuarioModel toUsuarioModel(Map<String, Object?> map) {
  return UsuarioModel(
    id: map['id'] as int,
    name: map['name'] as String,
    username: map['username'] as String,
    email: map['email'] as String,
    address: Address(
      street: map['street'] as String,
      suite: map['suite'] as String,
      city: map['city'] as String,
      zipcode: map['zipcode'] as String,
      geo: Geo(
        lat: map['lat'] as String,
        lng: map['lng'] as String,
      ),
    ),
    phone: map['phone'] as String,
    website: map['website'] as String,
    company: Company(
      name: map['company_name'] as String,
      catchPhrase: map['company_catchPhrase'] as String,
      bs: map['company_bs'] as String,
    ),
    listaTareas: [],
  );
}

TareaModel toTareaModel(Map<String, Object?> map) {
  return TareaModel(
    userId: map['userId'] as int,
    id: map['id'] as int,
    title: map['title'] as String,
    completed: () {
      if (map['completed'] == 1) {
        return true;
      } else {
        return false;
      }
    }(),
  );
}
