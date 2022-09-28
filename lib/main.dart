import 'package:currency_converter/core/routing/AppRouter.dart';
import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/converter/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/converter/presentation/pages/currency_conversion_page.dart';
import 'package:currency_converter/features/historical_data/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/historical_data/presentation/pages/latest_page.dart';
import 'package:currency_converter/features/home/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/home/presentation/pages/home_page.dart';
import 'package:currency_converter/features/home/presentation/widgets/app_bar.dart';
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
        BlocProvider(create: (_) => di.inj<CurrencyConversionBloc>()),
        BlocProvider(create: (_) => di.inj<LatestConversionsBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        home: MainPage(),
        onGenerateRoute: AppRouter.generateRoutes,
      ),
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Home"),
      body: Container(
        padding: kPagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100, style: FlutterLogoStyle.stacked),
            const SizedBox(height: 28),
            Text("Welcome to our app", style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red)),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return SupportedCurrenciesPage();
                },));
              },
              child: Container(
                height: 56,
                padding: kContentPadding,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),

                child: Center(child: Text("Supported Currencies", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),)),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return CurrencyConversionPage();
                },));
              },
              child: Container(
                height: 56,
                padding: kContentPadding,
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),

                child: Center(child: Text("Currencies Conversion", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
