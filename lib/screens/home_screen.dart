import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_card.dart';
import 'user_form_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Participantes', style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: prov.loadUsers,
              child: ListView.builder(
                itemCount: prov.users.length,
                itemBuilder: (_, i) => UserCard(user: prov.users[i]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const UserFormScreen(isEdit: false))),
        child: const Icon(Icons.add),
      ),
    );
  }
}
