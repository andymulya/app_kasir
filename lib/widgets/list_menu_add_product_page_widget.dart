import 'package:app_kasir/providers/list_menu_add_product_widget_provider.dart';
import 'package:app_kasir/widgets/simple_dialog_delete_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/add_form_provider.dart';
import '../providers/product_database_provider.dart';
import 'simple_dialog_form_widget.dart';

class ListMenuAddProductPageWidget extends StatelessWidget{
	final ProductDatabaseProvider datas;
	final AddFormProvider addFormProvider;

	const ListMenuAddProductPageWidget({required this.datas, required this.addFormProvider, super.key});

	@override
	Widget build(BuildContext context) => ListView.builder(
		itemCount: datas.products.length,
		itemBuilder: (context, i){
			return Container(
				margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
				height: 100,
				decoration: BoxDecoration(
					color: Colors.blue.shade200,
					borderRadius: BorderRadius.circular(10),
					boxShadow: [
						BoxShadow(
							color: Colors.black.withOpacity(0.5),
							offset: const Offset(2, 2),
							blurRadius: 0.2
						)
					]
				),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceAround,
					children: [
						//Tampilan index produk
						Text((i+1).toString()),

						//Tampilan Nama dan stock produk
						Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								//Nama produk
								Text(datas.products[i].name),

								//Stok produk
								Text('Stok: ${datas.products[i].stock.toString()}')
							],
						),

						//Harga produk
						Text('Rp. ${datas.products[i].price.toString()}'),

						SizedBox(
							child: Row(
								children: [
									IconButton(
										onPressed: () => _showSimpleDialogEdit(context, addFormProvider, datas, datas.products[i]),
										icon: const Icon(Icons.edit, color: Colors.green,)
									),

									IconButton(
										onPressed: () => _showSimpleDialog(context, datas, datas.products[i]),
										icon: const Icon(Icons.delete, color: Colors.red,)
									)
								],
							),
						)
					],
				),
			);
		}
	);
}

//View form untuk mengedit produk
void _showSimpleDialogEdit(BuildContext context, AddFormProvider addFormProvider, ProductDatabaseProvider productProvider, ProductModel datas) => showDialog(

	context: context, 
	builder: (context){

		final ListMenuAddProductWidgetProvider isChange = Provider.of<ListMenuAddProductWidgetProvider>(context);

		if(context.debugDoingBuild){
			isChange.isChange = false;

			addFormProvider.name.text = datas.name;
			addFormProvider.stock.text = datas.stock.toString();
			addFormProvider.price.text = datas.price.toString();

		}

		return SimpleDialogFormWidget(addFormProvider: addFormProvider, productProvider: productProvider, onPressed: (){
			if(addFormProvider.formKey.currentState!.validate()){
				productProvider.updateProduct(datas.id, {
					'name': addFormProvider.name.text,
					'stock': addFormProvider.stock.text,
					'price': addFormProvider.price.text
				});
				Navigator.pop(context);
			}
		});
	}
	
);

//View show dialog untuk produk yang ingin dihapus atau tidak
void _showSimpleDialog(BuildContext context, ProductDatabaseProvider action, ProductModel datas) => showDialog(context: context, 
	builder: (context) =>  SimpleDialogWidget(onPressed: (){
		action.deteleProduct(datas.id);
		Navigator.pop(context);
	})
);