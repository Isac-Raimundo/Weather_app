import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import '../extensions/string_extensions.dart';
import '../services/weatherService.dart';
import 'package:path_drawing/path_drawing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // largura da tela
  late double largura = MediaQuery.of(context).size.width;
  // controlador para pesquisar a cidade
  final TextEditingController _cityController = TextEditingController();
  // future vazia
  Future<Weather>? _weatherFuture;

  // Função que atualiza o estado do controlador se ele não estiver vazio
  void _search() {
    if (_cityController.text.isNotEmpty) {
      setState(() {
        _weatherFuture = WeatherService().searchWeather(_cityController.text);
      });
    }
  }

  // sombra para os icones
  BoxShadow _boxShadowIcon(
    Color color,
    double x,
    double y,
    dynamic blur,
    dynamic spread,
  ) {
    return BoxShadow(
      color: color,
      blurRadius: (blur as num).toDouble(),
      spreadRadius: (spread as num).toDouble(),
      offset: Offset(x, y),
    );
  }

  // função de escolher a sombra em função do icone
  List<BoxShadow>? _choosingIconShadow(String iconType) {
    if (iconType[2] == 'n') {
      return [_boxShadowIcon(Color(0xff48484a).withAlpha(80), 0, 10, 500, -40)];
    } else if (iconType[2] == 'd') {
      switch (iconType) {
        case '01d' || '02d' || '10d' || '11d':
          return [
            _boxShadowIcon(Color(0xffec6e4c).withAlpha(80), 0, 10, 400, -40),
          ];
        case '03d':
          return [
            _boxShadowIcon(Color(0xfff2f2f1).withAlpha(80), 0, 10, 500, -40),
          ];
        case '04d' || '09d' || '13d' || '50d':
          return [
            _boxShadowIcon(Color(0xff48484a).withAlpha(80), 0, 10, 500, -40),
          ];
        default:
          return [
            _boxShadowIcon(Color(0xff48484a).withAlpha(80), 0, 10, 500, -40),
          ];
      }
    }
    return null;
  }

  // função de escolher a sombra em função da sombra do icone
  List<BoxShadow>? _choosingContainerShadow(String iconType) {
    if (iconType[2] == 'n') {
      return [_boxShadowIcon(Color(0xff48484a).withAlpha(30), -6, -4, 5, 0.1)];
    } else if (iconType[2] == 'd') {
      switch (iconType) {
        case '01d' || '02d' || '10d' || '11d':
          return [
            _boxShadowIcon(Color(0xffec6e4c).withAlpha(30), -6, -4, 5, 0.1),
          ];
        case '03d':
          return [
            _boxShadowIcon(Color(0xfff2f2f1).withAlpha(30), -6, -4, 5, 0.1),
          ];
        case '04d' || '09d' || '13d' || '50d':
          return [
            _boxShadowIcon(Color(0xff48484a).withAlpha(30), -6, -4, 5, 0.1),
          ];
        default:
          return [
            _boxShadowIcon(Color(0xff48484a).withAlpha(30), -6, -4, 5, 0.1),
          ];
      }
    }
    return null;
  }

  // widget que será chamado caso o usuário pesquise um nome de cidade
  Widget _buildWeatherInfo(Weather weatherSearched) {
    // conversão do tempo ---
    DateTime nascerSol = DateTime.fromMillisecondsSinceEpoch(
      weatherSearched.sunrise * 1000,
    );
    DateTime porSol = DateTime.fromMillisecondsSinceEpoch(
      weatherSearched.sunset * 1000,
    );
    DateTime dataAtual = DateTime.fromMillisecondsSinceEpoch(
      weatherSearched.dt * 1000,
    );
    // se o número é menor que 10, não retorna o 0. O .padLeft traz um 0 à
    // esquerda sempre que só houver um número
    String hora =
        "${dataAtual.hour.toString().padLeft(2, '0')}:${dataAtual.minute.toString().padLeft(2, '0')}";
    String nascerFormatado =
        "${nascerSol.hour.toString().padLeft(2, '0')}:${nascerSol.minute.toString().padLeft(2, '0')}";
    String porFormatado =
        "${porSol.hour.toString().padLeft(2, '0')}:${porSol.minute.toString().padLeft(2, '0')}";
    // ----------------------

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: largura * 0.5,
              height: largura * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(90),
                color: Color(0xff1f2029),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 8, 0, 8),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hoje ',
                        style: TextStyle(color: Colors.white.withAlpha(180)),
                      ),
                      TextSpan(
                        text: '[${hora}] : ${dataAtual}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Icon(
              Icons.more_horiz_outlined,
              color: Colors.white.withAlpha(100),
              size: largura * 0.1,
            ),
          ],
        ),

        // Texto da cidade
        Padding(
          padding: EdgeInsets.only(top: largura * 0.02),
          child: Row(
            spacing: largura * 0.01,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.location_solid,
                size: largura * 0.09,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.white.withAlpha(100), blurRadius: 50),
                ],
              ),
              Text(
                '${weatherSearched.cityName}, ${weatherSearched.country}',
                maxLines: 2,
                style: TextStyle(
                  fontSize: largura * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.white.withAlpha(100), blurRadius: 50),
                  ],
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [
            // Ícone do clima
            Container(
              decoration: BoxDecoration(
                boxShadow: _choosingIconShadow(weatherSearched.icon.toString()),
              ),
              child: Image.network(
                'https://openweathermap.org/img/wn/${weatherSearched.icon}@2x.png',
                scale: 0.1,
                width: largura * 0.45,
                height: largura * 0.45,
              ),
            ),

            // Temperatura atual, sensação térmica e info. do clima
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(largura * 0.08),
                color: Color(0xff1f2029),
                boxShadow: _choosingContainerShadow(
                  weatherSearched.icon.toString(),
                ),
              ),
              width: largura * 0.45,
              height: largura * 0.3,
              child: Column(
                spacing: 0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Temperatura atual + sensação térmica
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Temperatura atual
                      Padding(
                        padding: EdgeInsets.only(
                          left: largura * 0.04,
                          top: largura * 0.01,
                        ),
                        child: Text(
                          weatherSearched.temperature.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: largura * 0.14,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.white.withAlpha(100),
                                blurRadius: 50,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // sensação térmica
                      Padding(
                        padding: EdgeInsets.only(right: largura * 0.04),
                        child: Text(
                          '/${weatherSearched.feelsLike.toStringAsFixed(0)}º',
                          style: TextStyle(
                            fontSize: largura * 0.09,
                            color: Colors.white.withAlpha(100),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: largura * 0.04),
                    child: Text(
                      weatherSearched.description.toFirstCharToUpperCase(),
                      style: TextStyle(
                        fontSize: largura * 0.035,
                        color: Colors.white.withAlpha(90),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // espaço entre os elementos
        SizedBox(height: largura * 0.04),

        // Nascer e por do sol
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(largura * 0.08),
            color: Color(0xff1f2029),
            boxShadow: [
              BoxShadow(
                color: Color(0xff22252f).withAlpha(170),
                blurRadius: 90,
                spreadRadius: 20,
              ),
            ],
          ),
          padding: EdgeInsets.only(left: largura * 0.05, right: largura * 0.05),
          width: double.infinity,
          height: largura * 0.4,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: CustomPaint(
                  size: Size(largura * 0.8, 100),
                  painter: LinhaCurva(),
                ),
              ),
              Positioned(
                top: 110,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nascerFormatado,
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: largura * 0.04,
                      ),
                    ),
                    Text(
                      porFormatado,
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: largura * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // espaço entre os elementos
        SizedBox(height: largura * 0.04),

        //Texto min. max.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mín.',
              style: TextStyle(
                color: Colors.white.withAlpha(60),
                fontSize: largura * 0.04,
              ),
            ),
            Text(
              'Máx.',
              style: TextStyle(
                color: Colors.white.withAlpha(60),
                fontSize: largura * 0.04,
              ),
            ),
          ],
        ),
        // Temperatura mínima e máxima
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '| ${weatherSearched.tempMin.toStringAsFixed(0)}º C',
              style: TextStyle(
                color: Color(0xff7adfed),
                fontSize: largura * 0.13,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Color(0xff7adfed).withAlpha(100),
                    blurRadius: 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50, // Altura da linha vertical
              child: VerticalDivider(
                thickness: 1.5, // Grossura da linha
                color: Colors.white.withAlpha(40),
                width: 40, // Espaço total que o widget ocupa na horizontal
                indent: 1, // Espaço no topo
                endIndent: 1, // Espaço na base
              ),
            ),
            Text(
              '| ${weatherSearched.tempMax.toStringAsFixed(0)}º C',
              style: TextStyle(
                color: Color(0xfff9c157),
                fontSize: largura * 0.13,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Color(0xfff9c157).withAlpha(100),
                    blurRadius: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: largura * 0.04),
        Divider(),
        SizedBox(height: largura * 0.04),
        Row(
          spacing: largura * 0.04,
          children: [
            Icon(
              CupertinoIcons.wind,
              size: largura * 0.13,
              color: Colors.white,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${weatherSearched.windSpeed.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.08,
                      shadows: [
                        Shadow(
                          color: Colors.white.withAlpha(100),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: ' km/h',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.06,
                      shadows: [
                        Shadow(
                          color: Colors.white.withAlpha(100),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: largura * 0.02),
        Row(
          spacing: largura * 0.04,
          children: [
            Icon(
              Icons.water_drop_outlined,
              size: largura * 0.13,
              color: Colors.white,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${weatherSearched.humidity.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.08,
                      shadows: [
                        Shadow(
                          color: Colors.white.withAlpha(100),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: '%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.06,
                      shadows: [
                        Shadow(
                          color: Colors.white.withAlpha(100),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2d2f3e),
      // backgroundColor: Color(0xff22252f),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(largura * 0.05),
          child: Column(
            spacing: largura * 0.05,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de pesquisa
              Container(
                height: largura * 0.15,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff22252f),
                      blurRadius: 90,
                      spreadRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Campo para digitar cidade
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: 'Digite uma cidade...',
                          hintStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Color(0xff1f2029),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(largura * 0.06),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: largura * 0.05,
                        ),
                        onSubmitted: (value) => _search(),
                      ),
                    ),

                    // icone depois do campo
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: largura * 0.07,
                      ),
                      onPressed: _search,
                    ),
                  ],
                ),
              ),

              // Se não houver pesquisa, mostra um texto para o usuário
              if (_weatherFuture == null)
                Center(
                  child: Text(
                    'Inicie uma busca!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: largura * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              // Se houber pesquisa, crirá um construtor para pegar as info
              // do json.
              else
                FutureBuilder<Weather>(
                  future: _weatherFuture,
                  builder: (context, snapshot) {
                    // Carregando
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // Erro
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text(
                          'Cidade não encontrada ou erro na busca.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: largura * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    // Sucesso em pegar os dados da api
                    if (snapshot.hasData) {
                      final dataOfApi = snapshot.data!;
                      return _buildWeatherInfo(dataOfApi);
                    }
                    return Container();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinhaCurva extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint arcoTrace =
        Paint() // paintarc
          ..color = Colors
              .white38 // Cor da linha
          ..style = PaintingStyle
              .stroke // "Stroke" significa apenas a linha (sem preenchimento)
          ..strokeWidth =
              3 // Espessura da linha
          ..strokeCap = StrokeCap.round;

    Paint arcoPreen = Paint()
      ..color = Colors
          .white // Cor da linha
      ..style = PaintingStyle
          .stroke // "Stroke" significa apenas a linha (sem preenchimento)
      ..strokeWidth =
          3 // Espessura da linha
      ..strokeCap = StrokeCap.round;

    Paint sol = Paint()..color = Color(0xfff9d71c);
    Paint luzSol = Paint()
      ..color = Color(0xfff9d71c).withAlpha(110)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    Path caminho = Path();

    // 1. Onde a linha começa (Esquerda, Altura 100)
    caminho.moveTo(0, 100);

    // 2. A curva: quadraticBezierTo(X do topo, Y do topo, X final, Y final)
    caminho.quadraticBezierTo(
      size.width / 2,
      0, // O ponto central que puxa a linha para cima (o topo do arco)
      size.width,
      100, // O ponto onde a linha termina na direita
    );

    Path pathMetade = Path();
    for (PathMetric measure in caminho.computeMetrics()) {
      pathMetade.addPath(
        measure.extractPath(0, measure.length * 0.5), // 0.5 = 50%
        Offset.zero,
      );
    }

    canvas.drawPath(
      dashPath(
        caminho,
        dashArray: CircularIntervalList<double>([
          9,
          5,
        ]), // 10px linha, 5px espaço
      ),
      arcoTrace,
    );
    canvas.drawPath(pathMetade, arcoPreen);
    canvas.drawCircle(Offset(size.width / 2, 50), 20, luzSol);
    canvas.drawCircle(Offset(size.width / 2, 50), 15, sol);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
