import 'package:flutter/material.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:go_router/go_router.dart';

class PalestrasPage extends StatelessWidget {
  final Map<String, dynamic> activityData;

  const PalestrasPage({Key? key, required this.activityData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Activity activity = Activity.fromJson(activityData);

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
            GoRouter.of(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${activity.title['pt-br']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Descrição: ${activity.description['pt-br']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Horário: ${activity.start} - ${activity.end}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Local: ${activity.locations != null && activity.locations!.isNotEmpty ? activity.locations![0]['title']['pt-br'] : 'Local não especificado'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Palestrante: ${activity.people != null && activity.people!.isNotEmpty ? activity.people![0]['name'] : 'Palestrante não especificado'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


  /*
  class Palestras extends StatefulWidget {
    @override
    State<Palestras> createState() => _PalestrasState();
  }

  class _PalestrasState extends State<Palestras> {
    bool _favorited = false;
    bool _loading = false;
    bool _disposed =
        false; // Adicione uma flag para verificar se o widget foi descartado

    @override
    void dispose() {
      _disposed = true; // Marque o widget como descartado ao ser descartado
      super.dispose();
    }

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
              onPressed: () => GoRouter.of(context).pop()),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(color: Colors.pink),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nome da atividade',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 25,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Esta atividade é parte de NOME DA ATIVIDADE',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
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
                                if (!_disposed) {
                                  setState(() {
                                    _loading = true;
                                  });

                                  // Simulação de processo assíncrono
                                  Future.delayed(Duration(seconds: 2), () {
                                    if (!_disposed) {
                                      setState(() {
                                        _favorited = !_favorited;
                                        _loading = false;
                                      });
                                    }
                                  });
                                }
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
                    SizedBox(height: 50),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod, risus nec gravida vulputate, magna tortor consequat ligula, ut varius justo lectus at nulla.',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Palestrantes',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).push('/autor'),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              'https://via.placeholder.com/150',
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
        ),
      );
    }
  }
  */