import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Weather App",
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 30
        ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            FutureBuilder(
              future: apicall(),
                builder: (context,snapshot) {
                  if(snapshot.hasData){
                    return Column(
                        children: [
                        Container(
                          height: 650,
                        width: 800,
                        color: Colors.indigoAccent,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data['name'].toString(),
                            style: TextStyle(
                              fontSize: 55,
                              fontStyle: FontStyle.normal
                            ),
                  ),

                        ),
                        const Icon(
                            Icons.cloud_rounded,
                            color:Colors.white,
                            size:60
                        ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                  child:Text('${snapshot.data['temp'].toString()}°C',
                          style: TextStyle(
                              fontSize: 40,
                              fontStyle: FontStyle.normal
                          ),
                        ),
                            ),
                  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:Text(snapshot.data['description'].toString(),
                        style: TextStyle(
                          fontSize: 35,
                          fontStyle: FontStyle.italic
                        ),
                        ),
                  ),
                  Container(
                    height: 70,
                  width: 600,
                  color: Colors.indigo,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Text('Max temperature:${snapshot.data['temp_max'].toString()}',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal
                          ),
                        ),
                  ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Text('Min temperature:${snapshot.data['temp_min'].toString()}',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal
                          ),
                        ),
                  ),
                        ],
                          ),
                  ),
                        Container(
                        height: 70,
                  width: 600,
                  color: Colors.indigo,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                  child:Text('Humidity:${snapshot.data['humidity'].toString()}',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal
                          ),
                        ),
                        ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Text('Pressure:${snapshot.data['pressure'].toString()}',
                  style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal
                  ),
                  ),
                        ),


                  ],

                        ),
                        ),
                        Container(
                          height: 70,
                          width: 600,
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Feels like:${snapshot.data['feels_like'].toString()}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Text('Country:${snapshot.data['country'].toString()}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal
                                  ),
                                ),
                              ),


                            ],

                          ),
                        ),



                        ],
                        ),

                    ),
                 ] );
                  }
                  else{
                    return CircularProgressIndicator();
                  }
                }
            )

          ],
        ),
      )
    );

}
}
Future apicall() async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=11542823490b7fbc3699f1079ca374e0&units=metric");
  final response = await http.get(url);
  print(response.body);
  final json =  jsonDecode(response.body);

  final output = {
    'description':json['weather'][0]['description'],
    'temp' : json['main']['temp'],
    'temp_max' : json['main']['temp_max'],
    'temp_min' : json['main']['temp_min'],
    'humidity' :  json['main']['humidity'],
    'name' :  json['name'],
    'pressure' : json['main']['pressure'],
    'country' : json['sys']['country'],
    'feels_like' : json['main']['feels_like']

  };
  return output;
}




