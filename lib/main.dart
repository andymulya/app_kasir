import 'package:app_kasir/providers/list_menu_add_product_widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/add_form_provider.dart';
import 'providers/cart_database_provider.dart';
import 'providers/product_database_provider.dart';
import 'providers/qty_widget_provider.dart';
import 'routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductDatabaseProvider()),
        ChangeNotifierProvider(create: (context) => CartDatabaseProvider()),
        ChangeNotifierProvider(create: (context) => AddFormProvider()),
        ChangeNotifierProvider(create: (context) => QtyWidgetProvider()),
        ChangeNotifierProvider(create: (context) => ListMenuAddProductWidgetProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: '/',
      ),
    );
  }
}