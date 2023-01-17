import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget{
	const AddProductPage({super.key});

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(
				title: const Text('Tambah Product'),
				actions: [
					IconButton(
						onPressed: (){
							_showSimpleDialog(context);
						},
						icon: const Icon(Icons.add)
					)
				],
			),
			body: Text('Hello World'),
		);
	} 
}

void _showSimpleDialog(BuildContext context){
	showDialog(context: context, 
		builder: (context) => SimpleDialog(
			children: [
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						const Padding(
						  padding: EdgeInsets.all(8.0),
						  child: Text('Tambah Produk'),
						),
						CloseButton(color: Colors.red, onPressed: () => Navigator.pop(context))
					],
				),
			],
	));
}