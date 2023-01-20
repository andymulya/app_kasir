import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../providers/product_database_provider.dart';

class ListMenuAddProductPageWidget extends StatelessWidget{
	final ProductDatabaseProvider datas;

	const ListMenuAddProductPageWidget({required this.datas, super.key});

	@override
	Widget build(BuildContext context){
		return ListView.builder(
			itemCount: datas.products.length,
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
									Text(datas.products[i].name),

									//Stok produk
									Text('Stok: ${datas.products[i].stock.toString()}')
								],
							),

							//Harga produk
							Text('Rp. ${datas.products[i].price.toString()}'),

							SizedBox(
								child: Row(
									children: [
										IconButton(
											onPressed: (){},
											icon: const Icon(Icons.edit, color: Colors.green,)
										),

										IconButton(
											onPressed: () => _showSimpleDialog(context, datas, datas.products[i]),
											icon: const Icon(Icons.delete, color: Colors.red,)
										)
									],
								),
							)
						],
					),
				);
			}
		);
	}
}

//View show dialog untuk produk yang ingin dihapus atau tidak
void _showSimpleDialog(BuildContext context, ProductDatabaseProvider action, ProductModel datas){
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
									action.deteleProduct(datas.id);
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