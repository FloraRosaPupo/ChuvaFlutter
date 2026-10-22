# Exercícios

Olá! Este repositório contém os exercícios de desenvolvimento da Chuva, você **deve** implementar pelo menos uma das tecnologias disponíveis, conforme sua preferência pessoal e aptidão.

Só serão considerados para correção testes em que as verificações do Github Actions estejam passando (verdinhas).

# Tecnologias
## Dart
Nesse caso você deve implementar um protótipo de alta fidelidade no figma de uma tela para você implementar em Flutter, [veja detalhes aqui](https://github.com/chuva-inc/exercicios-2023/tree/master/dart/).




## Desenvolvimento e validação

O aplicativo está em `dart`. Use Flutter 3.41.1. Na pasta do aplicativo, execute:

```sh
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter run
```

A CI valida análise e testes em pushes e pull requests. Serviços externos precisam de configuração própria.

## Testes de integração históricos

`dart/integration_test/` contém expectativas visuais do exercício original, dependentes de dispositivo. A CI padrão executa os testes de modelo/serviço em `dart/test/`; o build iOS é manual. Golden files não são regenerados automaticamente para fazer uma validação passar.
