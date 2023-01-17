import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{
	const MainPage({super.key});

	@override
	Widget build(BuildContext context){
		return Scaffold(
			floatingActionButton: FloatingActionButton(
				onPressed: () => Navigator.pushNamed(context, '/add_product'),
				child: const Icon(
					Icons.add
				),
			),
			appBar: AppBar(
				title: const Text('Menu Product')
			),
			body: Text('Hello World'),
		);
	}
}