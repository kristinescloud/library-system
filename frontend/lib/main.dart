import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_system_frontend/views/home_page.dart';
import 'package:library_system_frontend/views/login_register_page.dart';
import 'package:library_system_frontend/views/account_page.dart';
import 'package:library_system_frontend/providers/auth_provider.dart';
import 'package:library_system_frontend/theme/theme.dart';
import 'package:library_system_frontend/theme/util.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
    @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Hind", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Library System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 49, 27, 88)),
        useMaterial3: true,
      ),
      //theme.light(),
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({super.key});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    final List<Widget> _pages = <Widget>[
      HomePage(),
      authState.isAuthenticated ? AccountPage() : LoginRegisterPage(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'My Account'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
