
import 'package:bloc/bloc.dart';


import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/todo_app/todo_layout.dart';
import 'package:todo_app/shared/bloc_observer.dart';



void main()
{
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}


class MyApp extends StatelessWidget
{


  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
