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
	Future<int> insertData(Map<String, dynamic> data) async {
		final db = await ProductDatabase().createDatabase();
		try{
			final insert = await db.insert(tableProduct.tableName,data);
			return insert;
		}catch(e){
			rethrow;
		}
	}

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
}