import 'package:app_kasir/models/product_model.dart';
import 'package:app_kasir/models/table_cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/table_product_model.dart';

mixin SqfliteIntance{

	static const String _databaseName = 'database_app';
	static const int _databaseVersion = 1;

	Database? _database;

	//Product Table
	static final tableProduct = TableProductModel();

	//Cart Table
	static final tableCart = TableCartModel();

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
			await db.transaction((txn) async {
				await txn.execute('CREATE TABLE ${tableProduct.tableName}(${tableProduct.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${tableProduct.name} TEXT, ${tableProduct.stock} INTEGER, ${tableProduct.price} INTEGER)');
				await txn.execute('CREATE TABLE ${tableCart.tableName}(${tableCart.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${tableCart.name} TEXT, ${tableCart.qty} INTEGER, ${tableCart.price} INTEGER)');
			});
		}catch(e){
			rethrow;
		}
	}

	//Ambil semua data
	Future<List<dynamic>> getDatas();

	//Tambah data ke database
	Future<int> insertData(Map<String, dynamic> data);
}