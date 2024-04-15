import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  late final List<Widget> _screens;

  final _inexadorScreen = ['Categorias', 'Favoritos'];

  @override
  void initState() {
    super.initState();
    _screens = [
      const CategoriesScreem(),
      FavoriteScreen(
        favoriteMeals: widget.favoriteMeals,
      ),
    ];
  }

  _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_inexadorScreen[_selectedScreenIndex])),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedScreen,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).hintColor,
          currentIndex: _selectedScreenIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categorias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
          ]),
    );
  }
}
