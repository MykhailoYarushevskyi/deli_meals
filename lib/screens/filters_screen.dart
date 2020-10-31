import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters['gluten'];
    _isLactoseFree = widget.currentFilters['lactose'];
    _isVegan = widget.currentFilters['vegan'];
    _isVegetarian = widget.currentFilters['vegetarian'];
  }

  bool _isGlutenFree;
  bool _isVegan;
  bool _isVegetarian;
  bool _isLactoseFree;

  Widget _buildSwitchListTile({
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Adjust your Meal settings',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  title: 'Gluten-Free',
                  description: 'Only include gluten-free meals',
                  currentValue: _isGlutenFree,
                  updateValue: (newValue) => setState(
                    () => _isGlutenFree = newValue,
                  ),
                ),
                _buildSwitchListTile(
                  title: 'Lactose-Free',
                  description: 'Only include lactose-free meals',
                  currentValue: _isLactoseFree,
                  updateValue: (newValue) => setState(
                    () => _isLactoseFree = newValue,
                  ),
                ),
                _buildSwitchListTile(
                  title: 'Vegetarian',
                  description: 'Only include vegetarian meals',
                  currentValue: _isVegetarian,
                  updateValue: (newValue) => setState(
                    () => _isVegetarian = newValue,
                  ),
                ),
                _buildSwitchListTile(
                  title: 'Vegan',
                  description: 'Only include vegan meals',
                  currentValue: _isVegan,
                  updateValue: (newValue) => setState(
                    () => _isVegan = newValue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
