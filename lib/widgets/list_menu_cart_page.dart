import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../providers/cart_database_provider.dart';
import '../providers/product_database_provider.dart';
import '../providers/qty_widget_provider.dart';
import 'detail_product_widget.dart';
import 'qty_widget.dart';

class ListMenuCartPageWidget extends StatelessWidget{
	final CartDatabaseProvider datas;
	const ListMenuCartPageWidget({required this.datas, super.key});

	@override
	Widget build(BuildContext context){

		final ProductDatabaseProvider productProvider = Provider.of<ProductDatabaseProvider>(context);
		final QtyWidgetProvider qtyProvider = Provider.of<QtyWidgetProvider>(context);

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
								onPressed: () => _showSimpleModalBottomSheet(context, datas.carts[i], productProvider, datas, qtyProvider),
								icon: const Icon(Icons.delete, color: Colors.red)
							)
						],
					),
				);
			}
		);
	}
}

//View show modal bottom sheet untuk menghapus jumlah produk yang ada di cart
void _showSimpleModalBottomSheet(BuildContext context, CartModel datas, ProductDatabaseProvider productProvider, CartDatabaseProvider cartProvider, QtyWidgetProvider qtyProvider){

	showModalBottomSheet(
		context: context,
		builder: (context){

			if(context.debugDoingBuild){
				if(qtyProvider.qty != 1) qtyProvider.qty = 1;
			}

			return SizedBox(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
						//Qty
						QtyWidget(stock: datas.qty),

						//Detail Product
						DetailProductWidget(title: 'Nama Produk :', subTitle: datas.name),
						DetailProductWidget(title: 'Jumlah :', subTitle: datas.qty.toString()),
						DetailProductWidget(title: 'Harga :', subTitle: datas.price.toString()),

						//Tombol untuk menghapus product dikeranjang
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: ElevatedButton(
							  	onPressed: (){
							  		Navigator.pop(context);
							  		_showSimpleDialog(context, datas, productProvider, cartProvider, qtyProvider);
							  	},
							  	child: Row(
							  		mainAxisAlignment: MainAxisAlignment.center,
							  		children: const[
							  			Text('Hapus Produk'),
							  			Icon(Icons.delete)
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


//View show dialog untuk produk yang ingin dihapus atau tidak
void _showSimpleDialog(BuildContext context, CartModel datas, ProductDatabaseProvider productProvider, CartDatabaseProvider cartProvider, QtyWidgetProvider qtyProvider){

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

									if(datas.qty == qtyProvider.qty || datas.qty < 1){

										cartProvider.deleteCart(datas.id);
										productProvider.checkIdAndDelete(datas, qtyProvider.qty);
										Navigator.pop(context);

									}else{
										cartProvider.updateCart(datas.id, {
											'name': datas.name,
											'qty': datas.qty - qtyProvider.qty,
											'price': datas.price
										});

										productProvider.checkIdAndDelete(datas, qtyProvider.qty);
										Navigator.pop(context);
									}

									
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