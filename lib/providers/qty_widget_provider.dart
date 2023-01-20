import 'package:flutter/material.dart';

class QtyWidgetProvider extends ChangeNotifier{
	int _qty = 1;
	int get qty => _qty;
	set qty(qty){
		_qty = qty;
		notifyListeners();
	}

	void plus(int stock){
		if(_qty < stock) _qty++;
		notifyListeners();
	}

	void min(){
		if(_qty > 1) _qty--;	
		notifyListeners();
	}
}