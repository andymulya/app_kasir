import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget{
	const CustomButtonWidget({super.key});

	@override
	Widget build(BuildContext context) => SizedBox(
	  	height: MediaQuery.of(context).size.height / 7,
	    child: GestureDetector(
	      child: Container(
	      	color: Colors.blue,
	      	child: const Center(child: Text('Total')),
	      ),
	      onTap: (){},
	    ),
	);
}