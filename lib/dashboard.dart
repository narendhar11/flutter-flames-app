import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String url = "https://airquality.bandgi.com/query?db=datatecnics&q=SELECT value FROM temperature  where unit = '382B78037DA5' and time > now()  - 5s";
  //final String url = "https://swapi.co/api/people";
  List data;

  Future<String> getData() async {
    var response = await http.get(
      // Encode the url
        url,
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    // Logs the response body to the console
    print(response.body);

    // To modify the state of the app, use this method
    setState(() {
      // Get the JSON data
      var dataConvertedToJSON = json.decode(response.body);
      // Extract the required part and assign it to the global variable named data
      data = dataConvertedToJSON['results'];
      print(data);
    });

    return "Successfull";
  }


  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: Text("Retrieve JSON Data via HTTP GET"),
          ),
          body: new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: Text(
                              // Read the name field value and set it in the Text widget
                              data[index],
                              // set some style to text
                              style: TextStyle(
                                  fontSize: 20.0),
                            ),
                            // added padding
                            padding: const EdgeInsets.all(15.0),
                          ),
                        )
                      ],
                    ),
                  ),
                );

//                  ListTile(
//                    leading: Icon(
//                      Icons.wb_sunny,
//                      color: Colors.orange,
//                      size: 50.0,
//                    ),
//                    title: new Text('Temperature', style: TextStyle(fontSize: 20.0)),
//                    subtitle: new Text(data[i], style: TextStyle(fontSize: 32.0))
//                );
              }
              ));

  }

  @override
  void initState(){
    super.initState();
    this.getData();
  }


}
