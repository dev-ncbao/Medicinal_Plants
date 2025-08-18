import 'package:sqflite/sqflite.dart';

import '../app_database.dart';
import '../services/search_history.service.dart';

class SearchHistorySeedData {
  static Future<void> _seed() async {
    final db = await AppDatabase.instance;

    final keywords = [
      "Đinh hương",
      "Hoàng liên",
      "Cam thảo",
      "Ngải cứu",
      "Gừng",
      "Nghệ",
      "Hương nhu",
      "Tía tô",
      "Rau má",
      "Cúc hoa",
      "Bạc hà",
      "Trinh nữ hoàng cung",
      "Xạ can",
      "Cỏ nhọ nồi",
      "Cây chó đẻ",
      "Cây lược vàng",
      "Cây hoàn ngọc",
      "Cây mật gấu",
      "Cây xương rồng",
      "Cây sả",
      "Cây lá bỏng",
      "Cây mã đề",
      "Cây dâu tằm",
      "Cây ké đầu ngựa",
      "Cây bồ công anh",
      "Cây cỏ mực",
      "Cây rau đắng",
      "Cây vối",
      "Cây sen",
      "Cây diệp hạ châu",
    ];

    for (final keyword in keywords) {
      await db.insert(
        SearchHistoryService.tableName,
        {'keyword': keyword, 'createdDate': DateTime.now().toIso8601String()},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  static Future<void> seedIfEmpty() async {
    final db = await AppDatabase.instance;
    final count = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT(*) FROM ${SearchHistoryService.tableName}',
      ),
    );

    if (count == 0) {
      await _seed();
    }
  }
}
