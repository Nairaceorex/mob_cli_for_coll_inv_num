import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({required this.selectedIndex, required this.callback});

  final int selectedIndex;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: callback,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Камера',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Отчет',
        )
      ],
    );
  }
}