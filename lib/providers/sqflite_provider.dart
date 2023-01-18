import 'package:app_kasir/models/product_model.dart';
import 'package:app_kasir/providers/add_form_provider.dart';
import 'package:app_kasir/services/sqflite_intance.dart';
import 'package:flutter/cupertino.dart';

class SqfliteProvider extends ChangeNotifier{
	List<ProductModel> _products = [];
	List<ProductModel> get products => _products;
	set products(product){
		_products = product;
		notifyListeners();
	}

	bool _isLoading = false;
	bool get isLoading => _isLoading;
	void setIsLoading(isLoading){
		_isLoading = isLoading;
		notifyListeners();
	}

	final _sqfliteIntance = SqfliteIntance();

	SqfliteProvider(){
		getProducts();
	}

	Future<void> checkDb() async {
		await _sqfliteIntance.createDatabase();
		notifyListeners();
	}

	Future<void> getProducts() async {
		setIsLoading(true);

		final result = await _sqfliteIntance.getDatas();
		_products = result;

		setIsLoading(false);
		notifyListeners();
	}

	Future<void> addProduct(AddFormProvider addFormProvider) async {
		try{
			await _sqfliteIntance.insertData({
				'name': addFormProvider.name.text,
				'stock': int.parse(addFormProvider.stock.text),
				'price': int.parse(addFormProvider.price.text)
			});
		}catch(e){
			rethrow;
		}
		notifyListeners();
	}


}