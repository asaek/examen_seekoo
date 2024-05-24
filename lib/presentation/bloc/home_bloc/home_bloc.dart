import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/user_cases/user_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsuariosUserCase getUsuariosUserCase;

  HomeBloc({required this.getUsuariosUserCase}) : super(HomeInitial()) {
    // on<HomeEvent>((HomeEvent event, Emitter<HomeState> emit) {});
    on<GetUsuarios>(_getUsuarios);
  }

  void _getUsuarios(GetUsuarios event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final List<UsuarioEntitie> usuarios =
          await getUsuariosUserCase.getUsuarios();
      print(usuarios);
      emit(HomeLoaded(usuarios: usuarios));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void getUsuarios() {
    add(GetUsuarios());
  }

  //* Comunicacion con blocs
  void streamerBorrarTarea(TareaEntity tarea) {
    print(tarea);
  }
}
