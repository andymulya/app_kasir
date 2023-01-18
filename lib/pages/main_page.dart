import 'package:app_kasir/providers/sqflite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_menu_main_page_widget.dart';

class MainPage extends StatelessWidget{
	const MainPage({super.key});

	//Untuk mendapatkan product ketika halaman baru dujalankan
	Future<void> getProducts(BuildContext context) async {
		final products = Provider.of<SqfliteProvider>(context);
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
				title: const Text('Menu Product')
			),
			body: Consumer<SqfliteProvider>(
				builder: (context, value, _){
					if(value.isLoading) return const Center(child: CircularProgressIndicator());
			    	if(value.products.isEmpty) return const Center(child: Text('Produk Kosong'));

			    	return ListMenuMainPageWidget(datas: value);
				},
			),
		);
	}
}