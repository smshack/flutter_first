import 'package:flutter/material.dart';

// 앱의 시작점을 정의하는 main 함수.
void main() {
  runApp(const MyApp());
}

// 앱의 루트 위젯인 MyApp 클래스. StatelessWidget을 상속받음.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp 위젯을 반환하여, 앱의 기본 디자인을 정의.
    return MaterialApp(
      title: '노트 앱', // 앱의 타이틀을 설정.
      theme: ThemeData(
        primarySwatch: Colors.blue, // 앱의 기본 색상을 설정.
      ),
      home: const MyHomePage(title: '노트 앱 홈'), // 앱의 홈 화면을 설정.
    );
  }
}

// 노트의 제목과 내용을 저장하기 위한 Note 클래스.
class Note {
  String title;
  String content;

  Note(this.title, this.content); // 생성자를 통해 제목과 내용을 초기화.
}

// 홈 화면을 표시하는 MyHomePage 클래스. StatefulWidget을 상속받아 상태를 관리.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title; // 홈 화면의 타이틀을 저장하는 변수 .

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // 상태 객체를 생성.
}

// MyHomePage의 상태를 관리하는 _MyHomePageState 클래스.
class _MyHomePageState extends State<MyHomePage> {
  List<Note> notes = []; // 노트를 저장할 리스트.

  // 새 노트를 추가하는 함수.
  void _addNote() async {
    // NewNotePage 화면으로 이동하고 결과를 기다림.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewNotePage()),
    );

    // 결과가 Note 객체인 경우 리스트에 추가.
    if (result != null && result is Note) {
      setState(() {
        notes.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 위젯을 사용하여 기본적인 레이아웃을 구성.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // 앱바의 타이틀을 표시.
      ),
      body: ListView.builder(
        itemCount: notes.length, // 노트 리스트의 길이만큼 아이템을 생성.
        itemBuilder: (BuildContext context, int index) {
          // 각 노트를 ListTile 위젯으로 표시.
          return ListTile(
            title: Text(notes[index].title), // 노트의 제목을 표시.
            subtitle: Text(notes[index].content), // 노트의 내용을 표시.
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote, // 누르면 _addNote 함수를 실행.
        tooltip: '노트 추가', // 버튼에 마우스를 올리면 툴팁 표시.
        child: const Icon(Icons.add), // + 아이콘을 표시.
      ),
    );
  }
}

// 새 노트를 작성하는 화면을 표시하는 NewNotePage 클래스. StatelessWidget을 상속받음.
class NewNotePage extends StatelessWidget {
  const NewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 텍스트 필드의 내용을 관리하기 위해 TextEditingController 사용.
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    // Scaffold 위젯을 사용하여 기본적인 레이아웃을 구성.
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 노트 작성'), // 앱바의 타이틀을 표시.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 패딩을 추가하여 내용과 경계 간격을 만듦.
        child: Column(
          children: [
            TextField(
              controller: titleController, // 제목 입력을 위한 텍스트 필드.
              decoration: const InputDecoration(
                labelText: '노트 제목', // 레이블 텍스트를 설정.
              ),
            ),
            const SizedBox(height: 20), // 위젯 간의 수직 간격을 만듦.
            TextField(
              controller: contentController, // 내용 입력을 위한 텍스트 필드.
              decoration: const InputDecoration(
                labelText: '노트 내용', // 레이블 텍스트를 설정.
              ),
              maxLines: null, // 무제한 행을 허용.
              keyboardType: TextInputType.multiline, // 여러 줄 입력을 허용.
            ),
            const SizedBox(height: 20), // 위젯 간의 수직 간격을 만듦.
            ElevatedButton(
              onPressed: () {
                // "저장" 버튼을 누르면 Note 객체를 생성하고 이전 화면으로 결과를 전달.
                final note = Note(titleController.text, contentController.text);
                Navigator.pop(context, note);
              },
              child: const Text('저장'), // 버튼의 텍스트를 설정.
            ),
          ],
        ),
      ),
    );
  }
}
