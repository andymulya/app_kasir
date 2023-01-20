import 'package:app_kasir/widgets/simple_dialog_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/add_form_provider.dart';
import '../providers/list_menu_add_product_widget_provider.dart';
import '../providers/product_database_provider.dart';
import '../widgets/list_menu_add_product_page_widget.dart';

class AddProductPage extends StatelessWidget{
	const AddProductPage({super.key});

	@override
	Widget build(BuildContext context){
		final addFormProvider = Provider.of<AddFormProvider>(context);
		final productProvider = Provider.of<ProductDatabaseProvider>(context);

		return Scaffold(
			appBar: AppBar(
				title: const Text('Tambah Produk'),
				actions: [
					IconButton(
						onPressed: () => _showSimpleDialogAdd(context, addFormProvider, productProvider),
						icon: const Icon(Icons.add)
					)
				],
			),
			body: Consumer<ProductDatabaseProvider>(
				builder: (context, value, _){
					if(value.isLoading) return const Center(child: CircularProgressIndicator());
					if(value.products.isEmpty) return const Center(child: Text('Produk Kosong'));

					return ListMenuAddProductPageWidget(datas: value, addFormProvider: addFormProvider);
				},
			),
		);
	} 
}

//View show dialog untuk form tambah data produk
void _showSimpleDialogAdd(BuildContext context, AddFormProvider addFormProvider, ProductDatabaseProvider productProvider) => showDialog(
	context: context, 
	builder: (context){

		final ListMenuAddProductWidgetProvider isChange = Provider.of<ListMenuAddProductWidgetProvider>(context);

		if(context.debugDoingBuild){
			isChange.isChange = true;

			addFormProvider.name.text = '';
			addFormProvider.stock.text = '';
			addFormProvider.price.text = '';
		}

		return SimpleDialogFormWidget(addFormProvider: addFormProvider, productProvider: productProvider, onPressed: (){
			if(addFormProvider.formKey.currentState!.validate()) productProvider.addProduct(addFormProvider);
		});
	}
);