import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_database_provider.dart';
import '../providers/product_database_provider.dart';
import '../providers/qty_widget_provider.dart';
import 'detail_product_widget.dart';
import 'qty_widget.dart';

class ListMenuMainPageWidget extends StatelessWidget{
	final ProductDatabaseProvider productProvider;
	const ListMenuMainPageWidget({required this.productProvider, super.key});

	@override
	Widget build(BuildContext context){

		final cartProvider = Provider.of<CartDatabaseProvider>(context);
		final qtyProvider = Provider.of<QtyWidgetProvider>(context);

		return ListView.builder(
			itemCount: productProvider.products.length,
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
									Text(productProvider.products[i].name),

									//Stok produk
									Text('Stok: ${productProvider.products[i].stock.toString()}')
								],
							),

							//Harga produk
							Text('Rp. ${productProvider.products[i].price.toString()}'),

							//Actions
							IconButton(
								onPressed: () => _showSimpleModalBottomSheet(context, productProvider.products[i], productProvider, cartProvider, qtyProvider),
								icon: const Icon(Icons.shopping_cart_checkout, color: Colors.blue,)
							)
						],
					),
				);
			}
		);
	}
}

void _showSimpleModalBottomSheet(BuildContext context, ProductModel datas, ProductDatabaseProvider productProvider, CartDatabaseProvider cartProvider, QtyWidgetProvider qtyProvider) => showModalBottomSheet(
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
					QtyWidget(stock: datas.stock),

					//Detail Product
					DetailProductWidget(title: 'Nama Produk :', subTitle: datas.name),
					DetailProductWidget(title: 'Stok :', subTitle: datas.stock.toString()),
					DetailProductWidget(title: 'Harga :', subTitle: datas.price.toString()),

					//Button add to cart
					Padding(
						padding: const EdgeInsets.all(8.0),
						child: ElevatedButton(
						  	onPressed: (){
						  		if(datas.stock >= qtyProvider.qty){
						  			cartProvider.addCart(datas, qtyProvider.qty);
							  		productProvider.updateProduct(datas.id, {
							  			'name': datas.name,
							  			'stock': datas.stock - qtyProvider.qty,
							  			'price': datas.price
							  		});
							  		Navigator.pop(context);
						  		}

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