import '../models/cart_model.dart';
import '../models/table_cart_model.dart';
import 'sqflite_intance.dart';

class CartDatabase with SqfliteIntance{

	//Cart Table
	static final tableCart = TableCartModel();

	//Ambil semua data
	@override
	Future<List<CartModel>> getDatas() async {
		final db = await CartDatabase().createDatabase();
		try{
			final List<Map<String, dynamic>> getDatas = await db.query(tableCart.tableName);
			final List<CartModel> result = getDatas.map((e) => CartModel.fromDatabase(e)).toList();
			return result;
		}catch(e){
			rethrow;
		}
	}

	//Tambah data ke database
	@override
	Future<int> insertData(Map<String, dynamic> data) async {
		final db = await CartDatabase().createDatabase();
		try{
			final insert = await db.insert(tableCart.tableName,data);
			return insert;
		}catch(e){
			rethrow;
		}
	}

	@override
	Future<int> deleteData(int id) async {
		final db = await CartDatabase().createDatabase();

		try{
			final delete = await db.delete(tableCart.tableName, where: 'id = ?', whereArgs: [id]);
			return delete;
		}catch(e){
			rethrow;
		}
	}
}