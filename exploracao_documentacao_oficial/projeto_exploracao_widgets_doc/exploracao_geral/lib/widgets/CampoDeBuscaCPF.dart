import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampoDeBuscaCPF extends StatefulWidget {
  const CampoDeBuscaCPF({super.key});

  @override
  _CampoDeBuscaCPFState createState() => _CampoDeBuscaCPFState();
}

class _CampoDeBuscaCPFState extends State<CampoDeBuscaCPF> {
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _localidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _regiaoController = TextEditingController();

  final FocusNode _cepFocusNode =
      FocusNode(); // FocusNode para detectar a saída de foco

  @override
  void initState() {
    super.initState();

    // Adiciona o listener ao FocusNode do campo CEP
    _cepFocusNode.addListener(() {
      if (!_cepFocusNode.hasFocus) {
        // Quando o foco é perdido, dispara a busca do CEP
        _buscarCEP();
      }
    });
  }

  @override
  void dispose() {
    _cepFocusNode.dispose();
    super.dispose();
  }

  // Função para buscar o CEP na API ViaCEP
  Future<void> _buscarCEP() async {
    final cep = _cepController.text;
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Verifica se houve erro na busca do CEP
        if (data['erro'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CEP não encontrado')),
          );
        } else {
          // Atualiza os campos com os dados do CEP
          setState(() {
            _logradouroController.text = data['logradouro'] ?? '';
            _bairroController.text = data['bairro'] ?? '';
            _localidadeController.text = data['localidade'] ?? '';
            _ufController.text = data['uf'] ?? '';
            _estadoController.text = data['estado'] ?? '';
            _estadoController.text = data['regiao'] ?? '';
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao buscar o CEP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao buscar o CEP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo de CEP sem botão, voltando ao tamanho original
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: _cepController,
                  focusNode: _cepFocusNode, // Atribui o FocusNode ao campo CEP
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CEP',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _logradouroController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Logradouro',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _bairroController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bairro',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _localidadeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Localidade',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _ufController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UF',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _ufController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Estado',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _ufController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Regiao',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
