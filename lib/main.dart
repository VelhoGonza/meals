import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories_meals_screan.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

import 'models/meal.dart';
import 'models/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  Settings settins = Settings();

  void _filterMeals(Settings settings) {
    setState(() {
      this.settins = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final lactoseFree = settings.isLactoseFree && !meal.isLactoseFree;
        final isVegan = settings.isVegan && !meal.isVegan;
        final isVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !lactoseFree &&
            !isVegetarian &&
            !isVegetarian &&
            !isVegan;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals?',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.pink,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light(useMaterial3: true).textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 30,
                ),
              ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            secondary: Colors.amber,
          )),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(
              meals: _availableMeals,
            ),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(
              onFavoriteAction: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(
              onSettingsChange: _filterMeals,
              settings: settins,
            ),
      },
    );
  }
}
