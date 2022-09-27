import 'package:currency_converter/features/home/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.inj<SupportedCurrenciesBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomePage(),
      ),
    );
  }
}
