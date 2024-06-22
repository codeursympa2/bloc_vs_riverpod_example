import 'package:bloc_vs_riverpod_example/page/facts_page.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/network/network_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: BlocProvider(
        create: (context) => NetworkInfoCubit(Connectivity()), //Pour la connectivité WIFI
        child: MaterialApp(
          title: 'Random Fact App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const FactsPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}


