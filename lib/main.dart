import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/favorite_recipes_screen.dart';
import 'package:recipe_book/screens/home_screen.dart';
import 'package:recipe_book/l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipesProvider()..fetchRecipes(),
        ),
      ],
      child: const MaterialApp(
        title: 'Recipe Book',
        home: RecipeBook(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            AppLocalizations.of(context)!.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(240, 255, 255, 255),
            tabs: [
              Tab(text: 'Home', icon: Icon(Icons.home)),
              Tab(text: "Favorites", icon: Icon(Icons.favorite)),
            ],
          ),
        ),
        body: TabBarView(
          children: [const HomeScreen(), const FavoriteRecipesScreen()],
        ),
      ),
    );
  }
}
