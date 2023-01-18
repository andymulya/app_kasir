import 'package:app_kasir/providers/add_form_provider.dart';
import 'package:app_kasir/providers/product_database_provider.dart';
import 'package:app_kasir/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductDatabaseProvider()),
        ChangeNotifierProvider(create: (context) => AddFormProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: '/',
      ),
    );
  }
}