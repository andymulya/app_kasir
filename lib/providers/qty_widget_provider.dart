import 'package:flutter/material.dart';

class QtyWidgetProvider extends ChangeNotifier{
	int _qty = 0;
	int get qty => _qty;

	void plus(){
		_qty++;
		notifyListeners();
	}

	void min(){
		if(_qty > 0){
			_qty--;
		}
		notifyListeners();
	}
}