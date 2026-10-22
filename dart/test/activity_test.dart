import 'package:flutter_test/flutter_test.dart';
import 'package:chuva_dart/model/activity.dart';
import 'package:chuva_dart/services/activity_service.dart';
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('título simples é normalizado para tradução pt-br', () {
    final activity=Activity.fromJson({'title':'Palestra'});
    expect(activity.title,{'pt-br':'Palestra'});
    expect(activity.people,isEmpty);
  });
  test('serviço carrega atividades reais e filtra pelo dia', () async {
    final service=ActivityService();
    final all=await service.fetchActivities();
    expect(all,isNotEmpty);
    final day=DateTime.parse(all.first.start).day;
    final filtered=await service.fetchActivities(day:day);
    expect(filtered,isNotEmpty);
    expect(filtered.every((a)=>DateTime.parse(a.start).day==day),isTrue);
  });
}
