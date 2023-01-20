import '../models/product_model.dart';
import '../models/table_product_model.dart';
import 'sqflite_intance.dart';

class ProductDatabase with SqfliteIntance{

	//Product Table
	static final tableProduct = TableProductModel();

	//Ambil semua data
	@override
	Future<List<ProductModel>> getDatas() async {
		final db = await ProductDatabase().createDatabase();
		try{
			final List<Map<String, dynamic>> getDatas = await db.query(tableProduct.tableName);
			final List<ProductModel> result = getDatas.map((e) => ProductModel.fromDatabase(e)).toList();
			return result;
		}catch(e){
			rethrow;
		}
	}

	//Tambah data ke database
	@override
	Future<int> insertData(Map<String, dynamic> datas) async {
		final db = await ProductDatabase().createDatabase();
		try{
			final insert = await db.insert(tableProduct.tableName,datas);
			return insert;
		}catch(e){
			rethrow;
		}
	}

	//Menghapus data di database
	@override
	Future<int> deleteData(int id) async {
		final db = await ProductDatabase().createDatabase();
		try{
			final delete = await db.delete(tableProduct.tableName, where: 'id = ?', whereArgs: [id]);
			return delete;
		}catch(e){
			rethrow;
		}
	}

	//Memperbarui data di database
  	@override
 	 Future<int> updateData(int id, Map<String, dynamic> datas) async {
    	final db = await ProductDatabase().createDatabase();

		try{
			final update = await db.update(tableProduct.tableName, datas, where: 'id = ?', whereArgs: [id]);

			return update;
		}catch(e){
			rethrow;
		}
	}

	//Ambil stock data yg dipilih
	Future<int> getStock(int id) async {
		final db = await ProductDatabase().createDatabase();

		try{
			final check = await db.query(tableProduct.tableName, where: 'id = ?', whereArgs: [id]);
			final List<ProductModel> generate = check.map((e) => ProductModel.fromDatabase(e)).toList();
			final result = generate.map((e) => e.stock).toList();
			return result[0];

		}catch(e){
			rethrow;
		}
	}

	//Check data didalam database, kalau ada akan return id jika tidak ada akan return nilai 0
	Future<int> checkData(int id) async {
		final db = await ProductDatabase().createDatabase();

		try{
			final check = await db.query(tableProduct.tableName, where: 'id = ?', whereArgs: [id]);
			final List<ProductModel> resultId = check.map((e) => ProductModel.fromDatabase(e)).toList();
			
			for(var e in resultId){
				if(e.id == id){
					return 1;
				}
			}

			return 0;

		}catch(e){
			rethrow;
		}
	}
}