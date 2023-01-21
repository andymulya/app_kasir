import 'package:app_kasir/providers/add_form_provider.dart';
import 'package:app_kasir/providers/cart_database_provider.dart';
import 'package:app_kasir/providers/list_menu_add_product_widget_provider.dart';
import 'package:app_kasir/providers/product_database_provider.dart';
import 'package:app_kasir/providers/qty_widget_provider.dart';

void disposeAll(){
	AddFormProvider().dispose();
	AddFormProvider().disposeController();

	CartDatabaseProvider().dispose();
	CartDatabaseProvider().disposeDatabase();

	ProductDatabaseProvider().dispose();
	ProductDatabaseProvider().disposeDatabase();

	ListMenuAddProductWidgetProvider().dispose();
	QtyWidgetProvider().dispose();
}