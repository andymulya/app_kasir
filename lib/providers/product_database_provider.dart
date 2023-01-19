import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_database.dart';
import '../utility/func.dart';
import 'add_form_provider.dart';

class ProductDatabaseProvider extends ChangeNotifier{
	List<ProductModel> _products = [];
	List<ProductModel> get products => _products;
	set products(products){
		_products = products;
		notifyListeners();
	}

	bool _isLoading = false;
	bool get isLoading => _isLoading;
	void setIsLoading(isLoading){
		_isLoading = isLoading;
		notifyListeners();
	}

	final _productDatabase = ProductDatabase();

	ProductDatabaseProvider(){
		getProducts();
	}

	Future<void> getProducts() async {
		setIsLoading(true);

		final result = await _productDatabase.getDatas();
		_products = result;

		setIsLoading(false);
		notifyListeners();
	}

	Future<void> addProduct(AddFormProvider addFormProvider) async {
		try{
			await _productDatabase.insertData({
				'name': addFormProvider.name.text,
				'stock': convertPositif(int.parse(addFormProvider.stock.text)),
				'price': convertPositif(int.parse(addFormProvider.price.text))
			});
			await getProducts();
		}catch(e){
			rethrow;
		}
	}

	Future<void> updateProduct(int id, Map<String, dynamic> datas) async {
		_productDatabase.updateData(id, datas);
		await getProducts();
	}

	Future<void> deteleProduct(int id) async {
		try{
			await _productDatabase.deleteData(id);
			await getProducts();
		}catch(e){
			rethrow;
		}
	}


}