import 'package:flutter/material.dart';

import '../providers/cart_database_provider.dart';

class ListMenuCartPageWidget extends StatelessWidget{
	final CartDatabaseProvider datas;
	const ListMenuCartPageWidget({required this.datas, super.key});

	@override
	Widget build(BuildContext context){

		return ListView.builder(
			itemCount: datas.carts.length,
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
									Text(datas.carts[i].name),

									//Stok produk
									Text('Jumlah: ${datas.carts[i].qty.toString()}')
								],
							),

							//Harga produk
							Text('Rp. ${datas.carts[i].price.toString()}'),

							//Actions
							IconButton(
								onPressed: (){},
								icon: const Icon(Icons.remove_sharp, color: Colors.red)
							)
						],
					),
				);
			}
		);
	}
}