import 'package:flutter/material.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfilePressed;

  const LogoAppBar({
    super.key,
    required this.onProfilePressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/petAdoptLogo.png'),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2, // Border width
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.person,
              size: 32,
            ),
            onPressed: onProfilePressed,
          ),
        ),
      ],
    );
  }
}
