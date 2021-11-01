import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_excercise/bloc_counter/bloc_counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Day 6 Excercise',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: BlocProvider(
          create: (context) => BlocCounterCubit(),
          child: const MyHomePage(title: 'Counter'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  BlocBuilder<BlocCounterCubit, int>(builder: (context, state) {
                return Text(
                  'Counter: $state',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    child: FittedBox(
                      child: FloatingActionButton(
                          child: const Icon(Icons.add),
                          onPressed: () =>
                              context.read<BlocCounterCubit>().increment()),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  child: FittedBox(
                    child: FloatingActionButton(
                        child: const Icon(Icons.remove),
                        onPressed: () =>
                            context.read<BlocCounterCubit>().decrement()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
