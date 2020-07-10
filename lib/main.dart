import 'package:apptunix_task/api/movieListApi.dart';
import 'package:apptunix_task/screens/moviesScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Movies(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apptunix_Task',
        home: MyHome(),
        routes: {
          MoviesScreen.routeName:(ctx)=>MoviesScreen(),
        },
      ),
    );
  }
}

class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    final movieData=Provider.of<Movies>(context,listen: false);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: RaisedButton(onPressed: (){
            Navigator.pushNamed(context, MoviesScreen.routeName).then((_){
         movieData.clearList();
            });
          },child:Text('Show Movies')),
        ),
      );
  }
}