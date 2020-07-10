import 'package:apptunix_task/api/movieListApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  static const routeName = '/moviesScreen';

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
      ScrollController scroll= ScrollController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
    scroll.addListener((){
if(scroll.position.pixels==scroll.position.maxScrollExtent){
  Provider.of<Movies>(context).fetchMore();
}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<Movies>(context);
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () => movieData.fetchFiveMovie(),
        child: ListView.builder(
          controller: scroll,
          itemBuilder: (ctx, index) {
            if(index==movieData.moviesListData.length)
            return Center(child: CupertinoActivityIndicator());
            else
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          movieData.moviesListData[index].title,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://image.tmdb.org/t/p/w500/' +
                                  movieData.moviesListData[index].imageUrl),
                        ),
                      ],
                    ),
                    Text('Overview : ',style: TextStyle(fontSize: 16),),
                    SizedBox(height: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          movieData.moviesListData[index].overview,
                          softWrap: true,
                          maxLines: 10,
                        )),
                  ],
                ),
              ),
            );
          },
          itemCount: movieData.moviesListData.length+1,
        ),
      ),
    );
  }
}
