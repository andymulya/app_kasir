import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/cart_database.dart';
import '../utility/func.dart';

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
		getCarts();
	}

	//Ambil semua data cart
	Future<void> getCarts() async {
		setIsLoading(true);

		final result = await _cartDatabase.getDatas();
		_carts = result;

		setIsLoading(false);
		notifyListeners();
	}

	//menambahkan data cart
	Future<void> addCart(ProductModel product, int qty) async {
		final checkData = await _cartDatabase.checkData(product.id);

		try{
			if(checkData > 0){
				final getQty = await _cartDatabase.getQty(product.id);

				await _cartDatabase.updateData(product.id, {
					'name': product.name,
					'qty': qty + getQty,
					'price': convertPositif(product.price)
				});
			}else{
				await _cartDatabase.insertData({
					'id': product.id,
					'name': product.name,
					'qty': convertPositif(qty),
					'price': convertPositif(product.price)
				});
			}

			await getCarts();
		}catch(e){
			rethrow;
		}
	}

	//Memperbarui data di database
	Future<void> updateCart(int id, Map<String, dynamic> datas) async {
		await _cartDatabase.updateData(id, datas);
		await getCarts();
	}

	//Menghapus data di database
	Future<void> deleteCart(int id) async {
		try{
			await _cartDatabase.deleteData(id);
			await getCarts();
		}catch(e){
			rethrow;
		}
	}

	Future<void> disposeDatabase() => _cartDatabase.dispose();

}