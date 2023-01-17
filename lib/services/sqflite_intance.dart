import 'package:app_kasir/models/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteIntance{

	static const String _databaseName = 'database_app';
	static const int _databaseVersion = 1;

	Database? _database;

	//Product Table
	static const String tableName = 'product',
	id = 'id',
	name = 'name',
	stock = 'stock',
	price = 'price';

	Future<Database> createDatabase() async {
		if(_database != null) return _database!;
		_database = await _initDatabase();

		return _database!;
	}

	//Membuat Database
	static Future _initDatabase() async {
		try{
			final String documentsDirectory = await getDatabasesPath();
			final path = join(documentsDirectory, _databaseName);
			return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
		}catch(e){
			rethrow;
		}
	}

	//Membuat tabel
	static Future<void> _onCreate(Database db, int version) async {
		try{
			await db.execute('CREATE TABLE $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $stock INTEGER, $price INTEGER)');
		}catch(e){
			rethrow;
		}
	}

	//Ambil semua data
	Future<List<ProductModel>> getDatas() async {
		final db = await SqfliteIntance().createDatabase();
		try{
			final List<Map<String, dynamic>> getDatas = await db.query(tableName);
			final List<ProductModel> result = getDatas.map((e) => ProductModel.fromDatabase(e)).toList();
			return result;
		}catch(e){
			rethrow;
		}
	}

	//Tambah data ke database
	Future<int> insertData(Map<String, dynamic> data) async {
		final db = await SqfliteIntance().createDatabase();
		try{
			final insert = await db.insert(tableName,data);
			return insert;
		}catch(e){
			rethrow;
		}
	}

}