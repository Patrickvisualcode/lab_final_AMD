import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/user_form_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.indigo.shade700,
          child: Text(
            user.name[0].toUpperCase(),
            style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),
          ),
        ),
        title: Text(
          user.name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          user.email,
          style: GoogleFonts.poppins(color: Colors.grey.shade300),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.tealAccent),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserFormScreen(isEdit: true, user: user),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () async {
                await prov.removeUser(user.id!);
                Fluttertoast.showToast(
                  msg: "Eliminado",
                  backgroundColor: Colors.red.shade700,
                  textColor: Colors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
