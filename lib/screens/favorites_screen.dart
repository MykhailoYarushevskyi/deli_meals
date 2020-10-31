import 'package:deli_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;
  FavoritesScreen({this.favoriteMeals, this.toggleFavorite});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _removeFavoriteMeal(String mealId) {
    setState(() {
      widget.toggleFavorite(mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        '## FavoritesScreen: favoriteMeals.length = ${widget.favoriteMeals.length}');
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some'),
      );
    } else {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            margin: EdgeInsets.only(bottom: 10, top: 15),
            height: 50,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Text(
                'Your Favorite Meals',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return MealItem(
                  favoriteMode: 'inactive',
                  id: widget.favoriteMeals[index].id,
                  title: widget.favoriteMeals[index].title,
                  imageUrl: widget.favoriteMeals[index].imageUrl,
                  duration: widget.favoriteMeals[index].duration,
                  complexity: widget.favoriteMeals[index].complexity,
                  affordability: widget.favoriteMeals[index].affordability,
                  removeItem: _removeFavoriteMeal,
                );
              },
              itemCount: widget.favoriteMeals.length,
            ),
          )
        ],
      );
    }
  }
}
