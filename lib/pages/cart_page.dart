import 'package:app_kasir/widgets/calculating_widget.dart';
import'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_database_provider.dart';
import '../widgets/list_menu_cart_page.dart';


class CartPage extends StatelessWidget{
	const CartPage({super.key});

	@override
	Widget build(BuildContext context) => Scaffold(
		appBar: AppBar(
			title: const Text('Keranjang')
		),

		body: Consumer<CartDatabaseProvider>(
			builder: (context, datas, _){
				if(datas.isLoading) return const Center(child: CircularProgressIndicator());
				if(datas.carts.isEmpty) return const Center(child: Text('Keranjang kosong'));

				return Column(
					children: [
						Expanded(child: Container(child: ListMenuCartPageWidget(datas: datas))),
						const CalculatingWidget()
					],
				);
			},
		),
	);
}