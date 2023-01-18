class CartModel{
	final int id, qty, price;
	final String name;

	CartModel({required this.id, required this.name, required this.qty, required this.price});

	factory CartModel.fromDatabase(Map<String, dynamic> datas){
		return CartModel(
			id: datas['id'],
			name: datas['name'],
			qty: datas['qty'],
			price: datas['price']
		);
	}
}