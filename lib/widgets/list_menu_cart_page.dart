import 'package:flutter/material.dart';

import '../models/cart_model.dart';
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
					height: 100,
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
								onPressed: () => _showSimpleDialog(context, datas, datas.carts[i]),
								icon: const Icon(Icons.delete, color: Colors.red)
							)
						],
					),
				);
			}
		);
	}
}

//View show dialog untuk produk yang ingin dihapus atau tidak
void _showSimpleDialog(BuildContext context, CartDatabaseProvider action, CartModel data){
	showDialog(context: context, 
		builder: (context) =>  SimpleDialog(
			children: [
				const Padding(
					padding: EdgeInsets.all(8.0),
					child: Center(child: Text('Apakah anda yakin ingin menghapus produk ini?')),
				),

				SizedBox(
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: [

							ElevatedButton(
								onPressed: () => Navigator.pop(context),
								child: const Text('Tidak')
							),

							ElevatedButton(
								onPressed: (){
									action.deteleCart(data.id);
									Navigator.pop(context);
								},
								child: const Text('Ya'),
							),
						],
					),
				)
			]
		)
	);
}