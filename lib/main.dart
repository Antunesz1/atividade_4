
import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP DO ANTUNES',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
      ),
      home: const MyHomePage(title: 'App do Antunes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    carregarContador();
  }

  Future<void> carregarContador() async {
    final valorSalvo = await databaseHelper.buscarContador();

    if (!mounted) return;

    setState(() {
      _counter = valorSalvo;
    });
  }

  Future<void> _salvarContador() async {
    await databaseHelper.salvarContador(_counter);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Valor salvo com sucesso!'),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // FUNÇÃO ZERAR CONTADOR
  Future<void> zerarContador() async {
    await databaseHelper.salvarContador(0);

    if (!mounted) return;

    setState(() {
      _counter = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contador zerado com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _salvarContador,
            icon: const Icon(Icons.save),
            tooltip: 'Salvar',
          ),
          IconButton(
            onPressed: zerarContador,
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Zerar contador',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você pressionou o botão esta quantidade de vezes:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
