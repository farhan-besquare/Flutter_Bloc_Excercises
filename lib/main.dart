import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_excercise/bloc_counter/bloc_counter_cubit.dart';
import 'package:flutter_bloc_excercise/bloc_input/bloc_input_cubit.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BlocCounterCubit(),
          ),
          BlocProvider(
            create: (context) => BlocInputCubit(),
          )
        ],
        child: const MyHomePage(title: 'Day 6 Excercise'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = '';

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
            BlocBuilder<BlocInputCubit, String>(
                bloc: context.read<BlocInputCubit>(),
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter word: ',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                print(state);
                                context
                                    .read<BlocInputCubit>()
                                    .capitalise(state);
                              },
                              icon: const Icon(Icons.check_circle_rounded),
                            ),
                          ),
                          onChanged: (String? value) {
                            state = value!;
                          },
                        ),
                      )
                    ],
                  );
                }),
            BlocBuilder(
                bloc: context.read<BlocInputCubit>(),
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.tealAccent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Capatalised: $state')],
                    ),
                  );
                }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
