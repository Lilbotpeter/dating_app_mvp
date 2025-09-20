import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  final _tab = const ['/home/','/profile/']; //waiting for features default Home

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Modular.to.navigate(_tab.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i){
          setState(() => _index = i);
          Modular.to.navigate(_tab[i]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ]),
    );
  }
}