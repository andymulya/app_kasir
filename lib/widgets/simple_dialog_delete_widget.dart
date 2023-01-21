import 'package:flutter/material.dart';

class SimpleDialogDeleteWidget extends StatelessWidget{
	final Function onPressed;

	const SimpleDialogDeleteWidget({required this.onPressed, super.key});

	@override
	Widget build(BuildContext context) => SimpleDialog(
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
							onPressed: () => onPressed(),
							child: const Text('Ya'),
						),
					],
				),
			)
		]
	);
}