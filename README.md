# Agenda de Eventos — Desafio Chuva

## Descrição

Aplicativo Flutter de agenda de eventos desenvolvido como solução do desafio técnico da Chuva. Apresenta atividades de um catálogo JSON local, permite filtrar a programação por dia e consultar os detalhes de atividades e participantes. O repositório deriva do [exercício original da Chuva](https://github.com/chuva-inc/exercicios-2023).

## Stack e bibliotecas

Flutter/Dart, catálogo JSON local, go_router, Dio, intl e cached_network_image.

Dependências e versões declaradas: [dart/pubspec.yaml](dart/pubspec.yaml).

## Funcionalidades

- Agenda do evento.
- Filtro por dia.
- Detalhes de atividades e pessoas.

## Licença

Não há uma licença de distribuição definida para este repositório. Nenhuma licença MIT, Apache ou equivalente é concedida por este README. As atribuições e os direitos dos materiais de terceiros permanecem preservados. O conteúdo derivado mantém a atribuição ao projeto de origem indicada na descrição.

## Validação e limites

Parsing e filtro do catálogo. Os testes históricos em `integration_test` dependem de dispositivo e de referências visuais próprias.

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

## Organização e manutenção

Catálogo, serviço e telas foram reunidos em `dart/lib/features/agenda`; rotas permanecem em `dart/lib/app`. O serviço cuida da leitura/conversão, a tela apresenta os dados. Estado local é suficiente para este catálogo.

Veja [a revisão de desenvolvimento](docs/REVISAO.md) para decisões, testes e limites, e [o guia de contribuição](CONTRIBUTING.md) para o fluxo de manutenção.
