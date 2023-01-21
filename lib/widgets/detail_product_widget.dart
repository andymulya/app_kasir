import 'package:flutter/material.dart';

class DetailProductWidget extends StatelessWidget{
	final String title;
	final String subTitle;

	const DetailProductWidget({required this.title, required this.subTitle, super.key});

	@override
	Widget build(BuildContext context) => Padding(
	  padding: const EdgeInsets.all(8.0),
	  child: Row(
	  	mainAxisAlignment: MainAxisAlignment.spaceBetween,
	  	children: [
	  		Text(title),
	  		Text(subTitle)
	  	],
	  ),
	);
}