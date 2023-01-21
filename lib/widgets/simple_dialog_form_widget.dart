import 'package:flutter/material.dart';

import '../providers/add_form_provider.dart';

class SimpleDialogFormWidget extends StatelessWidget{
	final String titleForm,
	buttonName;
	final AddFormProvider addFormProvider;
	final Function onPressed;

	const SimpleDialogFormWidget({required this.titleForm, required this.buttonName, required this.addFormProvider,required this.onPressed, super.key});

	@override
	Widget build(BuildContext context){

		return SimpleDialog(
			children: [
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						Padding(
						  padding: const EdgeInsets.all(8.0),
						  child: Text(titleForm),
						),
						CloseButton(color: Colors.red, onPressed: () => Navigator.pop(context))
					],
				),

				SizedBox(
					child: Column(
					  	children: [
					  		Padding(
						  		padding: const EdgeInsets.all(8.0),
						  		child: Form(
						  		  	key: addFormProvider.formKey,
						  		  	child: Column(
						  		  	  	children: [
						  		  	  		//Form untuk nama produk
						  		  	  		TextFormField(
						  		  	  			controller: addFormProvider.name,
						  		  	  			autofocus: true,
						  		  	  			decoration: const InputDecoration(
						  		  	  				labelText: 'Nama Produk',
						  		  	  				hintText: 'Masukkan Nama Produk',
						  		  	  				border: OutlineInputBorder(),
						  		  	  			),
						  		  	  			validator: (value){
						  		  	  				if(value!.isEmpty) return 'Nama tidak boleh kosong';
						  		  	  				return null;
						  		  	  			},
						  		  	  		),

						  		  	  		//Form untuk stok produk
						  		  	  		Container(
						  		  	  			margin: const EdgeInsets.symmetric(vertical: 10),
							  		  	  		child: TextFormField(
							  		  	  			controller: addFormProvider.stock,
							  		  	  		  	decoration: const InputDecoration(
							  		  	  		  		labelText: 'Stok Produk',
							  		  	  		  		hintText: 'Masukkan Stok Produk',
							  		  	  		  		border: OutlineInputBorder(),
							  		  	  		  	),
							  		  	  		  	keyboardType: TextInputType.number,
							  		  	  		  	validator: (value){
							  		  	  		  		if(value!.isEmpty) return 'Masukkan stok yang valid';
							  		  	  		  		return null;
							  		  	  		  	},
							  		  	  		),
						  		  	  		),

						  		  	  		//Form untuk harga produk
						  		  	  		TextFormField(
						  		  	  			controller: addFormProvider.price,
						  		  	  			decoration: const InputDecoration(
						  		  	  				labelText: 'Harga Produk',
						  		  	  				hintText: 'Masukkan Harga Produk',
						  		  	  				border: OutlineInputBorder(),
						  		  	  			),
						  		  	  			keyboardType: TextInputType.number,
						  		  	  			validator: (value){
						  		  	  				if(value!.isEmpty) return 'Harga tidak boleh kosong';
						  		  	  				return null;
						  		  	  			},
						  		  	  		),

						  		  	  		//Tombol untuk mengirim data produk
						  		  	  		ElevatedButton(
						  		  	  			onPressed: () => onPressed(),
						  		  	  			child: Text(buttonName)
						  		  	  		)
						  		  	  	],
						  		  	),
						  		),
					  		),
					  	]
					),
				)
			],
		);
	}
}