import 'package:chuva_dart/pages/palestraspage.dart';
import 'package:flutter/material.dart';

class AuthorPage extends StatelessWidget {
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://via.placeholder.com/150', // Substituir pela URL da imagem do autor
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome Palestrante',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Text(
                      'Universidade',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Bio',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Atividades',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('data'),
            //colocar num list
            Expanded(
              child: ListView.builder(
                //itemCount: activitiesForSelectedDay.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Aqui você pode implementar a navegação para a página correspondente
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Palestras(), // Substitua DetalhesPage pela sua página de detalhes
                        ),
                      );
                    },
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
      ),
    );
  }
}
