class ProductModel{
	final int id, stock, price;
	final String name;

	ProductModel({required this.id, required this.name, required this.stock, required this.price});

	factory ProductModel.fromDatabase(Map<String, dynamic> datas){
		return ProductModel(
			id: datas['id'],
			name: datas['name'],
			stock: datas['stock'],
			price: datas['price']
		);
	}
}