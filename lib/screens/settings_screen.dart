import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChange;
  final Settings settings;

  const SettingsScreen(
      {super.key, required this.onSettingsChange, required this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChange,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChange(value);
        widget.onSettingsChange(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                    'Sem glutem',
                    'Só exibe refeições sem glutem',
                    settings.isGlutenFree,
                    (ativo) => setState(() {
                          settings.isGlutenFree = ativo;
                        })),
                _createSwitch(
                    'Sem lactose',
                    'Só exibe refeições sem lactose',
                    settings.isLactoseFree,
                    (ativo) => setState(() {
                          settings.isLactoseFree = ativo;
                        })),
                _createSwitch(
                    'Sem vegana',
                    'Só exibe refeições veganas',
                    settings.isVegan,
                    (ativo) => setState(() {
                          settings.isVegan = ativo;
                        })),
                _createSwitch(
                    'Sem vegetariana',
                    'Só exibe refeições vegetariana',
                    settings.isVegetarian,
                    (ativo) => setState(() {
                          settings.isVegetarian = ativo;
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
