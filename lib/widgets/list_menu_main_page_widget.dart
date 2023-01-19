import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_database_provider.dart';
import '../providers/product_database_provider.dart';
import 'detail_product_widget.dart';
import 'qty_widget.dart';

class ListMenuMainPageWidget extends StatelessWidget{
	final ProductDatabaseProvider datas;
	const ListMenuMainPageWidget({required this.datas, super.key});

	@override
	Widget build(BuildContext context){

		final cartProvider = Provider.of<CartDatabaseProvider>(context);

		return ListView.builder(
			itemCount: datas.products.length,
			itemBuilder: (context, i){
				return Container(
					margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
					height: MediaQuery.of(context).size.width / 4,
					decoration: BoxDecoration(
						color: Colors.blue.shade200,
						borderRadius: BorderRadius.circular(10),
						boxShadow: [
							BoxShadow(
								color: Colors.black.withOpacity(0.5),
								offset: const Offset(2, 2),
								blurRadius: 0.2
							)
						]
					),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children: [
							//Tampilan index produk
							Text((i+1).toString()),

							//Tampilan Nama dan stock produk
							Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									//Nama produk
									Text(datas.products[i].name),

									//Stok produk
									Text('Stok: ${datas.products[i].stock.toString()}')
								],
							),

							//Harga produk
							Text('Rp. ${datas.products[i].price.toString()}'),

							//Actions
							IconButton(
								onPressed: () => _showSimpleModalBottomSheet(context, datas.products[i], cartProvider),
								icon: const Icon(Icons.shopping_cart_checkout, color: Colors.blue,)
							)
						],
					),
				);
			}
		);
	}
}

void _showSimpleModalBottomSheet(BuildContext context, ProductModel datas, CartDatabaseProvider cartProvider){

	showModalBottomSheet(
		context: context,
		builder: (context){
			return SizedBox(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
						//Qty
						const QtyWidget(),

						//Detail Product
						DetailProductWidget(title: 'Nama Produk :', subTitle: datas.name),
						DetailProductWidget(title: 'Stok :', subTitle: datas.stock.toString()),
						DetailProductWidget(title: 'Harga :', subTitle: datas.price.toString()),

						//Button add to cart
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: ElevatedButton(
							  	onPressed: (){
							  		
							  	},
							  	child: Row(
							  		mainAxisAlignment: MainAxisAlignment.center,
							  		children: const[
							  			Text('Tambahkan ke keranjang'),
							  			Icon(Icons.shopping_cart_checkout_rounded)
							  		],
							  	),
							),
						)
					],
				),
			);
		}
	);
}