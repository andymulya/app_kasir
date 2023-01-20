import 'package:flutter/material.dart';

class DetailProductWidget extends StatelessWidget{
	final String title;
	final String subTitle;

	const DetailProductWidget({required this.title, required this.subTitle, super.key});

	@override
	Widget build(BuildContext context) => Row(
		mainAxisAlignment: MainAxisAlignment.spaceEvenly,
		children: [
			Text(title),
			Text(subTitle)
		],
	);
}