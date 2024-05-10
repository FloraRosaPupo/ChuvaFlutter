import 'package:chuva_dart/pages/palestraspage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> allActivities = [
    'Atividade 1 - 26 de Novembro de 2023',
    'Atividade 2 - 26 de Novembro de 2023',
    'Atividade 3 - 26 de Novembro de 2023',
    'Atividade 3 - 26 de Novembro de 2023',
    'Atividade 3 - 26 de Novembro de 2023',
    'Atividade 3 - 26 de Novembro de 2023',
    'Atividade 1 - 27 de Novembro de 2023',
    'Atividade 1 - 28 de Novembro de 2023',
    'Atividade 2 - 28 de Novembro de 2023',
    'Atividade 3 - 28 de Novembro de 2023',
    'Atividade 2 - 29 de Novembro de 2023',
    'Atividade 3 - 29 de Novembro de 2023',
    'Atividade 1 - 30 de Novembro de 2023',
    'Atividade 2 - 30 de Novembro de 2023',
    'Atividade 3 - 30 de Novembro de 2023',
  ];

  List<String> activitiesForSelectedDay = [];
  int selectedDay = 0;

  @override
  void initState() {
    super.initState();
    loadAllActivities();
  }

  void loadActivitiesForSelectedDay(String selectedDate) {
    setState(() {
      activitiesForSelectedDay = allActivities
          .where((activity) => activity.contains(selectedDate))
          .toList();
    });
  }

  void loadAllActivities() {
    setState(() {
      activitiesForSelectedDay = List.from(allActivities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Chuva 💜 Flutter',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Programação',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent,
                            ),
                            padding: EdgeInsets.all(8),
                            child:
                                Icon(Icons.calendar_month, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text('Exibindo todas as atividades'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //width: 85,
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDay = 0;
                      });
                      loadAllActivities();
                    },
                    child: Column(
                      children: [
                        Text(
                          'Nov',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: selectedDay == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Text(
                          '2023',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                for (var i = 26; i <= 30; i++)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDay = i;
                      });
                      loadActivitiesForSelectedDay('$i de Novembro de 2023');
                    },
                    child: Text(
                      '$i',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: selectedDay == i
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: activitiesForSelectedDay.length,
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
