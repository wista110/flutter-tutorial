import 'package:flutter/material.dart';
import 'counter_app.dart'; // カウンターアプリをインポート
import 'todo_app.dart';    // ToDoアプリをインポート

void main() {
  // どちらのアプリを起動するか選択
  runApp(const AppSelector());
}

// アプリ選択画面
class AppSelector extends StatelessWidget {
  const AppSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter学習アプリ',
      home: Scaffold(
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
      ),
    );
  }
}
