import 'package:app_kasir/pages/add_product_page.dart';
import 'package:flutter/material.dart';

import '../pages/main_page.dart';

final Map<String, WidgetBuilder> routes = {
	'/': (context) => const MainPage(),
	'/add_product': (context) => const AddProductPage()
};