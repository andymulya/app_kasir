import'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_database_provider.dart';
import '../widgets/list_menu_cart_page.dart';


class CartPage extends StatelessWidget{
	const CartPage({super.key});

	//Untuk mendapatkan cart ketika halaman baru dujalankan
	Future<void> getProducts(BuildContext context) async {
		final carts = Provider.of<CartDatabaseProvider>(context);
		await carts.getCarts();
	}

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(
				title: const Text('Keranjang')
			),

			body: Consumer<CartDatabaseProvider>(
				builder: (context, datas, _){
					if(datas.isLoading) return const Center(child: CircularProgressIndicator());
					if(datas.carts.isEmpty) return const Center(child: Text('Keranjang kosong'));

					return ListMenuCartPageWidget(datas: datas);
				},
			),
		);
	}
}