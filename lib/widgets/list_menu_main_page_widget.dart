import 'package:flutter/material.dart';

import '../providers/sqflite_provider.dart';

class ListMenuMainPageWidget extends StatelessWidget{
	final SqfliteProvider datas;
	const ListMenuMainPageWidget({required this.datas, super.key});

	@override
	Widget build(BuildContext context){
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
								onPressed: (){},
								icon: const Icon(Icons.shopping_cart, color: Colors.blue,)
							)

						],
					),
				);
			}
		);
	}
}