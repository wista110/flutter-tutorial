import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ===== Todoデータクラス =====
class Todo {
  final String id;
  final String title;
  bool isCompleted;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });
}

// ===== ToDoアプリのルートウィジェット =====
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '私のToDoリスト',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // textTheme: GoogleFonts.notoSansJpTextTheme(), ← この行をコメントアウト
      ),
      home: const TodoListPage(title: '私のToDoリスト'),
    );
  }
}

// ===== ToDoリストのメインページ =====
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key, required this.title});

  final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todos = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodo(String title) {
    if (title.trim().isEmpty) return;

    setState(() {
      _todos.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
        createdAt: DateTime.now(),
      ));
    });

    _textController.clear();
  }

  void _toggleTodoStatus(String id) {
    setState(() {
      for (var todo in _todos) {
        if (todo.id == id) {
          todo.isCompleted = !todo.isCompleted;
          break;
        }
      }
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('新しいTodoを追加'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'やることを入力してください',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _textController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTodo(_textController.text);
                Navigator.of(context).pop();
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '${_todos.length}件',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: _todos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Todoがありません\n右下の + ボタンで追加してみましょう！',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (bool? value) {
                        _toggleTodoStatus(todo.id);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isCompleted 
                            ? TextDecoration.lineThrough 
                            : TextDecoration.none,
                        color: todo.isCompleted 
                            ? Colors.grey 
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '作成: ${todo.createdAt.month}/${todo.createdAt.day} ${todo.createdAt.hour}:${todo.createdAt.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('確認'),
                              content: Text('「${todo.title}」を削除しますか？'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('キャンセル'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteTodo(todo.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('削除'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: '新しいTodoを追加',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
