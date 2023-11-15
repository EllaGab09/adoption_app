import 'package:flutter/material.dart';

class AnimalLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFavoriteToggle;

  const AnimalLogoAppBar({
    Key? key,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
              Icons.favorite_border,
              size: 32,
            ),
            onPressed: onFavoriteToggle,
          ),
        ),
      ],
    );
  }
}
