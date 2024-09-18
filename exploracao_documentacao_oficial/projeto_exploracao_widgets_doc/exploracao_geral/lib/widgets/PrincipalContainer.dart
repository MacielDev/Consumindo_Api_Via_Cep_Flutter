import 'package:exploracao_geral/widgets/CampoDeBuscaCPF.dart';
import 'package:flutter/material.dart';

class PrincipalContainer extends StatelessWidget {
  const PrincipalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          onPressed: null,
          icon: Icon(Icons.menu),
          tooltip: 'Menu principal',
        ),
        title: const Text('Endereco'),
        centerTitle: true,
      ),
      //Body
      body: const Form(child: CampoDeBuscaCPF()),
    );
  }
}
