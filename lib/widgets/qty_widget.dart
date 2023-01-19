import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/qty_widget_provider.dart';

class QtyWidget extends StatelessWidget{
	const QtyWidget({super.key});

	@override
	Widget build(BuildContext context){
		final qtyProvider = Provider.of<QtyWidgetProvider>(context);

		return SizedBox(
			width: MediaQuery.of(context).size.width,
			child: Row(
			  	mainAxisAlignment: MainAxisAlignment.end,
			  	children: [
			  		//Tombol -
			  		Container(
			  		  	margin: const EdgeInsets.all(10),
			  		  	width: 30,
			  		  	height: 30,
			  		  	decoration: BoxDecoration(
			  		  		color: Colors.blue,
			  		  		borderRadius: BorderRadius.circular(50),
			  		  	),
			  		  	child: GestureDetector(
			  		  		onTap: () => qtyProvider.min(),
			  		  		child: const Icon(Icons.remove, color: Colors.white)
			  		  	),
			  		),

			  		//Text Qty
			  		Text(qtyProvider.qty.toString()),

			  		//Tombol +
			  		Container(
			  		  	margin: const EdgeInsets.all(10),
			  		  	width: 30,
			  		  	height: 30,
			  		  	decoration: BoxDecoration(
			  		  		color: Colors.blue,
			  		  		borderRadius: BorderRadius.circular(50),
			  		  	),
			  		  	child: GestureDetector(
			  		  		onTap: () => qtyProvider.plus(),
			  		  		child: const Icon(Icons.add, color: Colors.white)
			  		  	),
			  		),
			  	],
			),
		);
	}
}