import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;

  TabsScreen({this.toggleFavorite, this.favoriteMeals});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    // !!! the index is given by Flutter automatically
    setState(() {
      _selectedPageIndex = index;
    });
  }

// @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _selectPage(_selectedPageIndex);
//   }
  @override
  initState() {
    super.initState();
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
        // we could be, for example, add list of activites for add to the appBar and etc:
        //'actitvites' : [RaisedButton(onPressed: null), IconButton(icon: null, onPressed: null)]
      },
      {
        'page': FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
          toggleFavorite: widget.toggleFavorite,
        ),
        'title': 'My Favorites',
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    //Create a TabBAr in the AppBar
    /* return DefaultTabController(
      length: 2,
      initialIndex = 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.category,
                ),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(
                  Icons.star,
                ),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    ); */
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).primaryColor, //if is the type: ...shifting
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).primaryColor, //if is the type: ...shifting
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
