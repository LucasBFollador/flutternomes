import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Para usar LocalStorage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo ao Flutter!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega para a Tela 2
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tela2()),
                );
              },
              child: Text('Ir para a Tela 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  @override
  _Tela2State createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  TextEditingController _controller = TextEditingController();
  List<String> _namesList = []; // Lista para armazenar os nomes

  @override
  void initState() {
    super.initState();
    _loadNames(); // Carregar os nomes ao iniciar a tela
  }

  // Carregar os nomes armazenados no LocalStorage
  _loadNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Carregar a lista de nomes ou inicializar como uma lista vazia
      _namesList = prefs.getStringList('names') ?? [];
    });
  }

  // Salvar o nome na lista e no LocalStorage
  _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Adiciona o nome à lista
    setState(() {
      _namesList.add(_controller.text);
    });
    // Salva a lista atualizada no LocalStorage
    prefs.setStringList('names', _namesList);
    _controller.clear(); // Limpa o campo de texto após salvar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Digite seu nome:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Nome',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveName(); // Salva o nome e atualiza a lista
              },
              child: Text('Salvar Nome'),
            ),
            SizedBox(height: 20),
            Text(
              'Nomes Salvos:',
              style: TextStyle(fontSize: 20),
            ),
            // Exibir os nomes salvos
            Expanded(
              child: ListView.builder(
                itemCount: _namesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_namesList[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Volta para a Tela Inicial
                Navigator.pop(context);
              },
              child: Text('Voltar para a Tela Inicial'),
            ),
          ],
        ),
      ),
    );
  }
}
