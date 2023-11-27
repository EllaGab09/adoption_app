import 'package:flutter/material.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const LogoAppBar({
    Key? key,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 8,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/petAdoptLogo.png'),
      ),
      // actions: [
      //   Container(
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       border: Border.all(
      //         color: Colors.white,
      //         width: 2, // Border width
      //       ),
      //     ),
      //     child: IconButton(
      //       icon: const Icon(
      //         Icons.person,
      //         size: 32,
      //       ),
      //       onPressed: onProfilePressed,
      //     ),
      //   ),
      // ],
    );
  }
}
