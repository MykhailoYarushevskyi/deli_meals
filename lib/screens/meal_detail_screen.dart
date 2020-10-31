import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen({this.toggleFavorite, this.isFavorite});

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> arg = ModalRoute.of(context).settings.arguments;
    final String favoriteMode = arg['favoriteMode'];
    final mealId = arg['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            '${selectedMeal.title}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: isFavorite(mealId)
                ? Icon(
                    Icons.star,
                    color: Theme.of(context).accentColor,
                  )
                : Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
            onPressed: favoriteMode == 'active'
                ? () => toggleFavorite(mealId)
                : () => {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          if (Navigator.of(context).canPop() == true)
            Navigator.of(context).pop(mealId);
        },
      ),
    );
  }
}
