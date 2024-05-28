import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/user_cases/user_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsuariosUserCase getUsuariosUserCase;
  final DelTaskUserCase delTaskUserCase;
  final InsertTaskUserCase insertTaskUserCase;
  late int usuarioNewTask;

  // UsuarioEntitie usuarioNewTask = UsuarioEntitie(
  //   id: 0,
  //   name: '',
  //   username: '',
  //   email: '',
  //   address: null,
  //   phone: '',
  //   website: '',
  //   company: '',
  //   error: '',
  //   listaTareas: null,
  // );

  HomeBloc({
    required this.delTaskUserCase,
    required this.getUsuariosUserCase,
    required this.insertTaskUserCase,
  }) : super(HomeInitial()) {
    // on<HomeEvent>((HomeEvent event, Emitter<HomeState> emit) {});
    on<GetUsuarios>(_getUsuarios);
  }

  void _getUsuarios(GetUsuarios event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final List<UsuarioEntitie> usuarios =
          await getUsuariosUserCase.getUsuarios();

      emit(HomeLoaded(usuarios: usuarios));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void getUsuarios() {
    add(GetUsuarios());
  }

  //* Comunicacion con blocs
  void streamerBorrarTarea(TareaEntity tarea) async {
    final bool borrado = await delTaskUserCase.deleteTask(tarea.id.toString());
  }

  void streamerInsertarTarea(TareaEntity tarea) async {
    // final TareaEntity tareaTest = TareaEntity(
    //   id: 0,
    //   title: 'Asaek',
    //   completed: false,
    //   userId: 1,
    // );

    // final int idInsertado = await insertTaskUserCase.insertTask(tareaTest);
    // print(idInsertado);
  }
}
