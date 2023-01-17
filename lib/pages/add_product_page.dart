import 'package:app_kasir/providers/add_form_provider.dart';
import 'package:app_kasir/providers/sqflite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget{
	const AddProductPage({super.key});

	@override
	Widget build(BuildContext context){
		final addFormProvider = Provider.of<AddFormProvider>(context);
		final sqfliteProvider = Provider.of<SqfliteProvider>(context);

		return Scaffold(
			appBar: AppBar(
				title: const Text('Tambah Product'),
				actions: [
					IconButton(
						onPressed: (){
							_showSimpleDialog(context, addFormProvider, sqfliteProvider);
						},
						icon: const Icon(Icons.add)
					)
				],
			),
			body: Consumer<SqfliteProvider>(
				builder: (context, value, _){
					if(value.products.isEmpty) return const Center(child: Text('Produk Kosong'));
					if(value.isLoading) return const Center(child: CircularProgressIndicator());

					return ListMenuAddProductWidget();
				},
			),
		);
	} 
}


//View show dialog untuk form tambah data produk
void _showSimpleDialog(BuildContext context, AddFormProvider addFormProvider, SqfliteProvider sqfliteProvider){
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
							  		  	  		  		if(value!.isEmpty) return 'Stok tidak boleh kosong';
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
						  		  	  			onPressed: () async {
						  		  	  				if(addFormProvider.formKey.currentState!.validate()){

						  		  	  					await sqfliteProvider.addProduct(addFormProvider);
						  		  	  					await sqfliteProvider.getProducts();
						  		  	  					addFormProvider.name.text = '';
						  		  	  					addFormProvider.stock.text = '';
						  		  	  					addFormProvider.price.text = '';

						  		  	  				}else{
						  		  	  					print('gagal mengirimkan data produk');	
						  		  	  				}
						  		  	  			},
						  		  	  			child: const Text('Tambahkan Produk')
						  		  	  		)
						  		  	  	],
						  		  	),
						  		),
					  		),
					  	]
					),
				)
			],
	));
}