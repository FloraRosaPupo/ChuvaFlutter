import 'package:chuva_dart/pages/autorpage.dart';
import 'package:flutter/material.dart';

class Palestras extends StatefulWidget {
  @override
  State<Palestras> createState() => _PalestrasState();
}

class _PalestrasState extends State<Palestras> {
  bool _favorited = false;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Chuva 💜 Flutter',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 17),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(color: Colors.pink /*Cor da disciplina*/),
            child: Padding(
              padding: EdgeInsets.all(5),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'Nome da atividade',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ]),
            ),
          ),

          // SE TIVER ATRELADO A OUTRA ATIVIDADE
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(color: Colors.blue),
            child: Padding(
              padding: EdgeInsets.all(5),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(
                  Icons.date_range,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Esta atividade é parte de NOME DA ATIVIDADE',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                )
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'TITULO',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule_outlined,
                      color: Colors.blue,
                      size: 17,
                    ),
                    Text('Dia e horario'),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 17,
                    ),
                    Text('Local'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: _loading
                          ? Colors.grey
                          : Colors.blue, // Cor cinza se estiver carregando
                      onPrimary: Colors.white,
                    ),
                    onPressed: _loading
                        ? null // Desabilitar o botão enquanto estiver carregando
                        : () {
                            setState(() {
                              _loading =
                                  true; // Indicador de carregamento ativado
                            });

                            // Simulação de processo assíncrono
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                                _favorited = !_favorited;
                                _loading =
                                    false; // Indicador de carregamento desativado
                              });
                            });
                          },
                    icon: _loading
                        ? Icon(Icons.cached) // Ícone de carregamento
                        : _favorited
                            ? const Icon(Icons.star)
                            : const Icon(Icons.star_outline),
                    label: _loading
                        ? Text('Processando...')
                        : Text(_favorited
                            ? 'Remover da sua agenda'
                            : 'Adicionar à sua agenda'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Palestrantes',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navegar para a página do autor
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthorPage()),
                    );
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          'https://via.placeholder.com/150', // Substituir pela URL da imagem do autor
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome Palestrante',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text('Universidade'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
