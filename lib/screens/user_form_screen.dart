import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class UserFormScreen extends StatefulWidget {
  final bool isEdit;
  final User? user;
  const UserFormScreen({super.key, required this.isEdit, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _form = GlobalKey<FormState>();
  late String name;
  late String email;

  @override
  void initState() {
    super.initState();
    name = widget.user?.name ?? '';
    email = widget.user?.email ?? '';
  }

  void save() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      final prov = Provider.of<UserProvider>(context, listen: false);
      try {
        if (widget.isEdit && widget.user != null) {
          final u = widget.user!..name = name..email = email;
          await prov.editUser(u);
          Fluttertoast.showToast(msg: "Actualizado", backgroundColor: Colors.green);
        } else {
          await prov.addUser(User(name: name, email: email));
          Fluttertoast.showToast(msg: "Registrado", backgroundColor: Colors.green);
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Participante' : 'Nuevo Participante', style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Ingresa nombre' : null,
                onSaved: (v) => name = v!.trim(),
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Ingresa email' : null,
                onSaved: (v) => email = v!.trim(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: save,
                child: Text(widget.isEdit ? 'Actualizar' : 'Registrar', style: GoogleFonts.poppins()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
