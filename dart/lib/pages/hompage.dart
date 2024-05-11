import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> activities = [];
  String jsonString = '';

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  void fetchActivities() async {
    try {
      jsonString = await rootBundle.loadString('assets/activities.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      setState(() {
        activities = jsonData['data'];
      });
    } catch (e) {
      print('Erro ao carregar atividades: $e');
    }
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
          // Seção de cabeçalho
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

          // Seção de seleção de dias
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextButton(
                    onPressed: fetchActivities,
                    child: Column(
                      children: [
                        Text(
                          'Nov',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                      loadActivitiesForSelectedDays(i);
                    },
                    child: Text(
                      '$i',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Lista de atividades
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                var activity = activities[index];
                var startTime = DateTime.tryParse(activity['start'] ?? '');
                var endTime = DateTime.tryParse(activity['end'] ?? '');

                if (startTime == null || endTime == null) {
                  return SizedBox
                      .shrink(); // Se não conseguirmos parsear o tempo, retornamos um widget vazio
                }

                var location = activity['locations'] != null &&
                        activity['locations'].isNotEmpty
                    ? activity['locations'][0]['title']['pt-br']
                    : 'Local não especificado';

                var title = activity['title'] != null &&
                        activity['title']['pt-br'] != null
                    ? activity['title']['pt-br']
                    : 'Título não especificado';

                var author =
                    activity['people'] != null && activity['people'].isNotEmpty
                        ? activity['people'][0]['name']
                        : 'Autor não especificado';

                var backgroundColor = activity['category'] != null &&
                        activity['category']['background-color'] != null
                    ? fromCssColor(activity['category']['background-color'])
                    : Colors.white;
                var cardColor = activity['category'] != null &&
                        activity['category']['color'] != null
                    ? fromCssColor(activity['category']['color'])
                    : Colors.white;

                return GestureDetector(
                  onTap: () => GoRouter.of(context).push('/palestras'),
                  child: Card(
                    color: backgroundColor,
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: cardColor, //A COR MUDA COM A DISCIPLINA
                            width: 3,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${startTime.hour}:${startTime.minute} - $location',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(author),
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

  void loadActivitiesForSelectedDays(int selectedDay) {
    setState(() {
      activities = jsonDecode(jsonString)['data'].where((activity) {
        // Verificar se o início da atividade está no intervalo de 26 a 30 de novembro de 2023
        var startDate = DateTime.tryParse(activity['start'] ?? '');
        if (startDate != null) {
          var day = startDate.day;
          var month = startDate.month;
          var year = startDate.year;
          return month == 11 && year == 2023 && day == selectedDay;
        }
        return false;
      }).toList();
    });
  }
}
