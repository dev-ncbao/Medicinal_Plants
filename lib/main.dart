import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medicinal_plants/widgets/result.dart';
import 'package:medicinal_plants/widgets/scanner.dart';
import 'package:medicinal_plants/widgets/search.dart';

import 'databases/app_database.dart';
import 'databases/seed_data/search_history.seed.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppDatabase.instance;
  SearchHistorySeedData.seedIfEmpty();

  ElevarmFontFamilies.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ElevarmThemeData.light(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget body = Container();
    if (_currentTabIndex == 0) {
      // body = Scanner(parentContext: context);
      // body = Result(parentContext: context);
      body = Search(parentContext: context);
    } else if (_currentTabIndex == 1) {
      // body = ElevarmAppLoaderOverlay(
      //   title: 'Đang tải dữ liệu...',
      //   titleColor: ElevarmColors.neutral,
      //   progressIndicatorColor: ElevarmColors.primary,
      // );
      // body =
    }

    return Scaffold(
      appBar: AppBar(title: Text('Thư Viện Cây Thuốc Nam')),
      body: body,
      bottomNavigationBar: ElevarmBottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: [
          ElevarmBottomNavigationBarItem(
            labelText: 'Tìm kiếm hình ảnh',
            iconAssetName: HugeIcons.strokeRoundedCameraAi,
            iconColor: ElevarmColors.primary500,
          ),
          ElevarmBottomNavigationBarItem(
            labelText: 'Tìm kiếm thủ công',
            iconAssetName: HugeIcons.strokeRoundedSearch01,
            iconColor: ElevarmColors.primary500,
          ),
        ],
      ),
    );
  }
}
