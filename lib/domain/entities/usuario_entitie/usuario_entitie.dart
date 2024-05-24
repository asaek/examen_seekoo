import 'package:examen_seekoo/domain/entities/entities.dart';

class UsuarioEntitie {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressUsuarioEntitie? address;
  final String? phone;
  final String? website;
  final String? company;
  final String? error;
  final List<TareaEntity>? listaTareas;

  UsuarioEntitie({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
    required this.error,
    required this.listaTareas,
  });
}
