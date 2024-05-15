import 'package:chuva_dart/pages/people.dart';
import 'package:chuva_dart/pages/palestraspage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Atividades extends StatefulWidget {
  @override
  State<Atividades> createState() => _AtividadesState();
}

class _AtividadesState extends State<Atividades> {
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
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 17,
          ),
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
            height: 25,
            decoration: BoxDecoration(color: Colors.pink),
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
          SizedBox(height: 10),
          Text(
            'TITULO',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
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
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: _loading ? Colors.grey : Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    onPressed: _loading
                        ? null
                        : () {
                            setState(() {
                              _loading = true;
                            });
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                                _favorited = !_favorited;
                                _loading = false;
                              });
                            });
                          },
                    icon: _loading
                        ? Icon(Icons.cached)
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-atividades',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              //itemCount: activitiesForSelectedDay.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => GoRouter.of(context).push('/palestras'),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.pink, //A COR MUDA COM A DISCIPLINA
                            width: 3,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Horario e local ',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'Titulo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text('Autor'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
