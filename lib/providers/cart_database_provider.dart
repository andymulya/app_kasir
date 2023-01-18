import 'package:app_kasir/providers/add_form_provider.dart';
import 'package:app_kasir/services/product_database.dart';
import 'package:app_kasir/utility/func.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../services/cart_database.dart';

class CartDatabaseProvider extends ChangeNotifier{
	List<CartModel> _carts = [];
	List<CartModel> get carts => _carts;
	set products(carts){
		_carts = carts;
		notifyListeners();
	}

	bool _isLoading = false;
	bool get isLoading => _isLoading;
	void setIsLoading(isLoading){
		_isLoading = isLoading;
		notifyListeners();
	}

	final _cartDatabase = CartDatabase();

	CartDatabaseProvider(){
		getProducts();
	}

	Future<void> getProducts() async {
		setIsLoading(true);

		final result = await _cartDatabase.getDatas();
		_carts = result;

		setIsLoading(false);
		notifyListeners();
	}

	Future<void> addCart(AddFormProvider addFormProvider) async {
		try{
			await _cartDatabase.insertData({
				'name': addFormProvider.name.text,
				'qty': convertPositif(int.parse(addFormProvider.stock.text)),
				'price': convertPositif(int.parse(addFormProvider.price.text))
			});
		}catch(e){
			rethrow;
		}
		notifyListeners();
	}


}