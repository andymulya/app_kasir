import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_database_provider.dart';
import '../widgets/list_menu_main_page_widget.dart';

class MainPage extends StatelessWidget{
	const MainPage({super.key});

	//Untuk mendapatkan product ketika halaman baru dijalankan
	Future<void> getProducts(BuildContext context) async {
		final products = Provider.of<ProductDatabaseProvider>(context);
		await products.getProducts();
	}

	@override
	Widget build(BuildContext context){

		return Scaffold(
			floatingActionButton: FloatingActionButton(
				onPressed: () => Navigator.pushNamed(context, '/add_product'),
				child: const Icon(
					Icons.add
				),
			),
			appBar: AppBar(
				title: const Text('Daftar Produk'),
				actions: [
					IconButton(
						onPressed: () => Navigator.pushNamed(context, '/cart_page'), 
						icon: const Icon(Icons.shopping_cart)
					)
				],
			),
			body: Consumer<ProductDatabaseProvider>(
				builder: (context, value, _){
					if(value.isLoading) return const Center(child: CircularProgressIndicator());
			    	if(value.products.isEmpty) return const Center(child: Text('Produk Kosong'));

			    	return ListMenuMainPageWidget(productProvider: value);
				},
			),
		);
	}
}