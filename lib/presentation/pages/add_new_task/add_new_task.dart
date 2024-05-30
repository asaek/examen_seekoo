import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/blocs.dart';

class AddNewTaskPage extends StatefulWidget {
  static const routerName = '/add_new_task';

  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late TareaEntity? isUpdateTask;
  String? _nameError;

  @override
  void initState() {
    isUpdateTask = context.read<UpdateTaskCubit>().state.tareaEntity;

    if (isUpdateTask != null) {
      _titleController.text = isUpdateTask!.title;
      if (isUpdateTask!.completed) {
        context.read<TaskCompletedCubit>().setTaskCompleted();
      } else {
        context.read<TaskCompletedCubit>().resetTaskCompleted();
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // El formulario es válido, realiza la acción deseada
      // Puedes acceder al título con _titleController.text
      // Y al estado del interruptor con _isCompleted

      if (isUpdateTask != null) {
        final TareaEntity updateTask = TareaEntity(
          id: isUpdateTask!.id,
          userId: isUpdateTask!.userId,
          title: _titleController.text,
          completed: context.read<TaskCompletedCubit>().state,
        );

        context.read<UpdateTaskCubit>().updateTask(
              table: 'tasks',
              task: updateTask,
            );
      } else {
        final TareaEntity newTask = TareaEntity(
          id: null,
          userId: context.read<HomeBloc>().usuarioNewTask,
          title: _titleController.text,
          completed: context.read<TaskCompletedCubit>().state,
        );

        context.read<HomeBloc>().newTaskSave(newTask);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (isUpdateTask == null) ? 'Agregar nueva tarea' : 'Actualiza la tarea',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: _nameError,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  // onChanged: _validateName,
                ),
                const SizedBox(height: 30),
                const _SwitchTareaCompletada(),
                const SizedBox(height: 30),
                ElevatedButton(
                  // onPressed: () {},
                  onPressed: _submitForm,
                  child: const Text('Agregar tarea'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchTareaCompletada extends StatelessWidget {
  const _SwitchTareaCompletada();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCompletedCubit, bool>(
      builder: (context, state) {
        final isSwitched =
            context.select((TaskCompletedCubit cubit) => cubit.state);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (isSwitched) ? 'Tarea Completada' : 'Tarea Pendiente',
              // 'Switch is ${isSwitched ? "ON" : "OFF"}',
              style: const TextStyle(fontSize: 24),
            ),
            const Spacer(),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                context.read<TaskCompletedCubit>().toggleTaskCompleted();
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        );
      },
    );
  }
}
