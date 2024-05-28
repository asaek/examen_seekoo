import 'package:flutter/material.dart';

class AddNewTaskPage extends StatefulWidget {
  static const routerName = '/add_new_task';

  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String? _nameError;

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
      print('Title: ${_titleController.text}');
    }
  }

  // void _validateName(String value) {
  //   if (value.isEmpty) {
  //     setState(() {
  //       _nameError = 'Por favor, ingresa tu nombre';
  //     });
  //   } else {
  //     setState(() {
  //       _nameError = null;
  //     });
  //   }
  // }
//! Se tiene que imlementar el switch con el cubit que cree
//! y que reaccione el bloc al crear la tarea
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar nueva tarea'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Tarea Completada',
          // 'Switch is ${isSwitched ? "ON" : "OFF"}',
          style: TextStyle(fontSize: 24),
        ),
        const Spacer(),
        Switch(
          value: true,
          onChanged: (value) {},
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ],
    );
  }
}
