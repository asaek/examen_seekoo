import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/user_cases/user_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

typedef NewTaskSendCallBack = void Function(TareaEntity newTask);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsuariosUserCase getUsuariosUserCase;
  final DelTaskUserCase delTaskUserCase;
  final InsertTaskUserCase insertTaskUserCase;
  late int usuarioNewTask;
  final Stream<TareaEntity> deleteTaskRecibe;
  final Stream<TareaEntity> updateTaskRecibe;

  final NewTaskSendCallBack? newTaskSendCallBack;

  HomeBloc({
    required this.delTaskUserCase,
    required this.getUsuariosUserCase,
    required this.insertTaskUserCase,
    required this.deleteTaskRecibe,
    required this.updateTaskRecibe,
    this.newTaskSendCallBack,
  }) : super(HomeInitial()) {
    // Listener for new tasks
    deleteTaskRecibe.listen((newTask) {
      streamerBorrarTarea(newTask);
    });

    updateTaskRecibe.listen((newTask) {
      streamUpdateTarea(newTask);
    });

    // on<HomeEvent>((HomeEvent event, Emitter<HomeState> emit) {});
    on<GetUsuarios>(_getUsuarios);
    on<NewTask>(_newTaskEmit);
    on<DeleteTask>(_deleteTask);
    on<UpdateTask>(_updateTask);
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

  void _newTaskEmit(NewTask event, Emitter<HomeState> emit) async {
    //? obtengo el id de la tarea insertada en la bd local
    final int idInsertado = await insertTaskUserCase.insertTask(event.newTask);

    //? Crear una nueva instancia de TareaEntity con el id actualizado
    final TareaEntity newTask = event.newTask.copyWith(id: idInsertado);

    newTaskSendCallBack?.call(newTask);

    usuarioNewTask = newTask.userId;
    if (state is HomeLoaded) {
      List<UsuarioEntitie> usuarios =
          (state as HomeLoaded).usuarios.map((usuario) {
        if (usuario.id == usuarioNewTask) {
          // Crear una nueva lista de tareas incluyendo la tarea actualizada
          final List<TareaEntity> listaTareas = List.from(usuario.listaTareas!);
          listaTareas.add(newTask);
          // Retornar un nuevo UsuarioEntitie con la lista de tareas actualizada
          return usuario.copyWith(listaTareas: listaTareas);
        }
        return usuario;
      }).toList();

      // Emitir un nuevo estado con la lista de usuarios actualizada
      emit(HomeLoaded(usuarios: usuarios));
    }
  }

  void _deleteTask(DeleteTask event, Emitter<HomeState> emit) async {
    final bool borrado =
        await delTaskUserCase.deleteTask(event.tarea.id.toString());

    if (borrado) {
      if (state is HomeLoaded) {
        List<UsuarioEntitie> usuarios =
            (state as HomeLoaded).usuarios.map((usuario) {
          if (usuario.id == event.tarea.userId) {
            final List<TareaEntity> listaTareas =
                List.from(usuario.listaTareas!);
            listaTareas.remove(event.tarea);
            return usuario.copyWith(listaTareas: listaTareas);
          }
          return usuario;
        }).toList();

        emit(HomeLoaded(usuarios: usuarios));
      }
    }
  }

  void _updateTask(UpdateTask event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      List<UsuarioEntitie> usuarios =
          (state as HomeLoaded).usuarios.map((usuario) {
        if (usuario.id == event.tarea.userId) {
          final List<TareaEntity> listaTareas = List.from(usuario.listaTareas!);
          final index =
              listaTareas.indexWhere((tarea) => tarea.id == event.tarea.id);
          listaTareas[index] = event.tarea;
          return usuario.copyWith(listaTareas: listaTareas);
        }
        return usuario;
      }).toList();
      emit(HomeLoaded(usuarios: usuarios));
    }
  }

  void getUsuarios() {
    add(GetUsuarios());
  }

  void newTaskSave(TareaEntity newTask) {
    add(NewTask(newTask: newTask));
  }

  //* Comunicacion con blocs
  void streamerBorrarTarea(TareaEntity tareaBorrar) {
    add(DeleteTask(tarea: tareaBorrar));
  }

  void streamUpdateTarea(TareaEntity tarea) {
    add(UpdateTask(tarea: tarea));
  }
}
