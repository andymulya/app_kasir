import 'package:app_kasir/models/cart_model.dart';
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

	//Mengambil semua data dari database
	Future<void> getProducts() async {
		setIsLoading(true);

		final result = await _productDatabase.getDatas();
		_products = result;

		setIsLoading(false);
		notifyListeners();
	}

	//Menambahkan data di database
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

	//Memperbarui data di database
	Future<void> updateProduct(int id, Map<String, dynamic> datas) async {
		_productDatabase.updateData(id, datas);
		await getProducts();
	}

	//Menghapus data di database
	Future<void> deteleProduct(int id) async {
		try{
			await _productDatabase.deleteData(id);
			await getProducts();
		}catch(e){
			rethrow;
		}
	}

	//Mengambil stock yang dipilih dari database
	Future<int> getStock(int id) async {
		return await _productDatabase.getStock(id);
	}

	//Mengcalculasi stock pada sebuah product
	Future<void> calcuProduct(CartModel datas, int qty) async {
		await updateProduct(datas.id, {
			'name': datas.name,
			'stock': await getStock(datas.id) + qty,
			'price': datas.price
		});
	}

}