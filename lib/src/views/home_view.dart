import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_x/src/models/weather.dart';
import 'package:weather_x/src/service/weather_service.dart';

class HomeView extends StatefulWidget {
  HomeView({required this.weather, super.key});

  Weather weather;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  late TextEditingController cityName;
  final weatherInstance = WeatherService(client: Client());

  void getWeather() async {
    widget.weather = await weatherInstance.getWeather(cityName: cityName.text);
  }

  @override
  void initState() {
    super.initState();
    cityName = TextEditingController(text: widget.weather.cityName);
  }

  @override
  void dispose() {
    cityName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;
    final appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/profile.png'),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: cityName,
                      decoration: const InputDecoration(
                        hintText: "City name here",
                        hintStyle: TextStyle(fontSize: 14),
                        contentPadding: EdgeInsets.zero,
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                        FocusScope.of(context).unfocus();
                      });
                      widget.weather = await weatherInstance.getWeather(
                          cityName: cityName.text);
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  const Text(
                    'Feels Like A good time to ride a bike 🚴',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  isLoading == true
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: LinearProgressIndicator())
                      : Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 320,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              right: appWidth / 4,
                              top: appHeight / 7,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Today's Like",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${widget.weather.temperature}°',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 32),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: appWidth / 4 - 28,
                              //center with value
                              bottom: appHeight / 12 + 24,
                              child: Transform.scale(
                                scale: 1.5,
                                child: Image.asset(
                                    'assets/images/${widget.weather.condition}.png'),
                                //["Rain","Snow","Clouds","Extreme","Clear"]
                                //['clear_night','windy',"cloudy_day","rain","thunderstorm"]
                              ),
                            ),
                            Positioned(
                              // left down
                              left: -2,
                              bottom: appHeight / 18,
                              child: Image.asset('assets/images/Extreme.png'),
                            ),
                            Positioned(
                              // left up
                              left: -2,
                              top: appHeight / 18,
                              child: Image.asset('assets/images/Clouds.png'),
                            ),
                            Positioned(
                              // right down
                              right: -12,
                              bottom: appHeight / 18,
                              child: Image.asset('assets/images/Clear.png'),
                            ),
                            Positioned(
                              // right up
                              right: 12,
                              top: appHeight / 18,
                              child: Image.asset('assets/images/Rain.png'),
                            ),
                            Positioned(
                              // center down
                              bottom: -10,
                              right: appWidth / 4 + 24,
                              child: Image.asset('assets/images/Snow.png'),
                            ),
                          ],
                        ),
                  const SizedBox(height: 44),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Today's Mood",
                              style: TextStyle(
                                color: Color(0xff36434d),
                              )),
                          Text(
                            "Very Good",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, height: 1.5),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Tomorrow's Mood",
                              style: TextStyle(
                                color: Color(0xff36434d),
                              )),
                          Text(
                            "Excellent",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, height: 1.5),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
              //   } else if (snapshot.hasError) {
              //     return const ScaffoldMessenger(
              //         child: SnackBar(
              //             content: Text("Error Occured, try again ")));
              //   } else if (snapshot.connectionState ==
              //       ConnectionState.waiting) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else {
              //     return const Center();
              //   }
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
