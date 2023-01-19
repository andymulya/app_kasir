import 'package:flutter/material.dart';

import '../pages/add_product_page.dart';
import '../pages/cart_page.dart';
import '../pages/main_page.dart';

final Map<String, WidgetBuilder> routes = {
	'/': (context) => const MainPage(),
	'/add_product': (context) => const AddProductPage(),
	'/cart_page': (context) => const CartPage()
};