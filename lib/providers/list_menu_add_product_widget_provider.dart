import 'package:flutter/material.dart';

class ListMenuAddProductWidgetProvider extends ChangeNotifier{
	bool _isChange = true;

	bool get isChange => _isChange;
	set isChange(isChange){
		_isChange = isChange;
		notifyListeners();
	}
}