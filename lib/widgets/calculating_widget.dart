import 'package:app_kasir/widgets/detail_product_widget.dart';
import 'package:flutter/material.dart';

import 'custom_button_widget.dart';

class CalculatingWidget extends StatelessWidget{
	const CalculatingWidget({super.key});

	@override
	Widget build(BuildContext context) => Container(
	  	decoration:  BoxDecoration(
	  		color: Colors.white,
	  		boxShadow: [
	  			BoxShadow(
	  				blurRadius: 4,
	  				spreadRadius: 1,
	  				color: Colors.black.withOpacity(0.3),
	  				offset: const Offset(0, 1)
	  			)
	  		]
	  	),
	  	child: Row(		  		
	  		children: [
	  			Expanded(
	  				flex: 4,
		  			child: Column(
		  			  	children: const[
		  			  		
		  			  		DetailProductWidget(title: 'Total harga', subTitle: '0'),
		  			  		
		  			  		DetailProductWidget(title: 'Total keranjang', subTitle: '0')
		  			  		
		  			  	],
		  			),
	  			),

	  			const Expanded(
	  				flex: 2,
	  				child: CustomButtonWidget()
	  			)
	  		],
	  	),
	);
}