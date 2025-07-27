import 'package:flutter/material.dart';
import 'counter_app.dart'; // カウンターアプリをインポート
import 'todo_app.dart';    // ToDoアプリをインポート

void main() {
  // どちらのアプリを起動するか選択
  runApp(const MyApp());
}

// ===== メインアプリウィジェット =====
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter学習アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        // google_fontsを一時的に無効化（文字化け防止）
      ),
      home: const AppSelector(), // Scaffoldを別ウィジェットに分離
    );
  }
}

// ===== アプリ選択画面ウィジェット =====
class AppSelector extends StatelessWidget {
  const AppSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter学習アプリ'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '学習したいアプリを選択してください',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            
            // カウンターアプリボタン
            ElevatedButton.icon(
              onPressed: () {
                // ここでNavigator.pushを使って画面遷移
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CounterApp(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('カウンターアプリ'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: Colors.green.shade100,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // ToDoアプリボタン
            ElevatedButton.icon(
              onPressed: () {
                // ここでNavigator.pushを使って画面遷移
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TodoApp(),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('ToDoリストアプリ'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: Colors.blue.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
