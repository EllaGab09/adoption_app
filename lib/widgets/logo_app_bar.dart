import 'package:flutter/material.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const LogoAppBar({
    super.key,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 8,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Image.asset(
            'assets/images/petAdoptLogo.png',
            width: 240,
          ),
        ));
  }
}
