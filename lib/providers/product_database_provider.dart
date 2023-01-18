import 'package:app_kasir/models/product_model.dart';
import 'package:app_kasir/providers/add_form_provider.dart';
import 'package:app_kasir/services/product_database.dart';
import 'package:app_kasir/utility/func.dart';
import 'package:flutter/cupertino.dart';

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
		}catch(e){
			rethrow;
		}
		notifyListeners();
	}


}