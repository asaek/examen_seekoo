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
  List<TareaEntity>? listaTareas;

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

  UsuarioEntitie copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    AddressUsuarioEntitie? address,
    String? phone,
    String? website,
    String? company,
    String? error,
    List<TareaEntity>? listaTareas,
  }) {
    return UsuarioEntitie(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      company: company ?? this.company,
      error: error ?? this.error,
      listaTareas: listaTareas ?? this.listaTareas,
    );
  }
}
