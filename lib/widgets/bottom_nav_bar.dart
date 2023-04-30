import 'package:flutter/material.dart';
import 'package:smartcity/berita/index.dart';

import '../berita/discover.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Berita()),
                );
              },
              icon: const Icon(Icons.home),
            ),
          ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Discover()),
              );
            },
            icon: const Icon(Icons.newspaper),
          ),
          label: 'Jelajahi',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}
