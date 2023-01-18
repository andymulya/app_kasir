import 'package:flutter/widgets.dart';

class AddFormProvider extends ChangeNotifier{
	GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	final TextEditingController _name = TextEditingController();
	final TextEditingController _stock = TextEditingController();
	final TextEditingController _price  = TextEditingController();

	GlobalKey<FormState> get formKey => _formKey;
	set formKey(formKey){
		_formKey = formKey;
		notifyListeners();
	}

	TextEditingController get name => _name;
	TextEditingController get stock => _stock;
	TextEditingController get price => _price;


}