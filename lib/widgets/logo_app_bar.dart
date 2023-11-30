import 'package:flutter/material.dart';

/// A custom app bar widget that displays a logo.
///
/// This widget extends [StatelessWidget] and implements [PreferredSizeWidget],
/// allowing it to be used as an app bar in Flutter applications.
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
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 8,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 55),
        child: Image.asset(
          'assets/images/petAdoptLogo.png',
          width: 240,
        ),
      ),
    );
  }
}
