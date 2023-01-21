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
	Future<int> insertData(Map<String, dynamic> datas) async {
		final db = await CartDatabase().createDatabase();
		try{
			final insert = await db.insert(tableCart.tableName,datas);
			return insert;
		}catch(e){
			rethrow;
		}
	}

	//Memperbarui data di database
	@override
	Future<int> updateData(int id, Map<String, dynamic> datas) async {
		final db = await CartDatabase().createDatabase();

		try{
			final update = await db.update(tableCart.tableName, datas, where: 'id = ?', whereArgs: [id]);

			return update;
		}catch(e){
			rethrow;
		}
	}


	//Menghapus data di database
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

	@override
	Future<dynamic> dispose() async => await CartDatabase().dispose();


	//Check data didalam database, kalau ada akan return id jika tidak ada akan return nilai 0
	Future<int> checkData(int id) async {
		final db = await CartDatabase().createDatabase();

		try{
			final check = await db.query(tableCart.tableName, where: 'id = ?', whereArgs: [id]);
			final List<CartModel> resultId = check.map((e) => CartModel.fromDatabase(e)).toList();
			
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

	//Ambil qty data yg dipilih
	Future<int> getQty(int id) async {
		final db = await CartDatabase().createDatabase();

		try{
			final check = await db.query(tableCart.tableName, where: 'id = ?', whereArgs: [id]);
			final List<CartModel> generate = check.map((e) => CartModel.fromDatabase(e)).toList();
			final result = generate.map((e) => e.qty).toList();
			return result[0];

		}catch(e){
			rethrow;
		}
	}
}