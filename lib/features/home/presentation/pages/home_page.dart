
import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/home/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/home/presentation/widgets/app_bar.dart';
import 'package:currency_converter/features/home/presentation/widgets/main_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: kPagePadding,
        child: BlocBuilder<SupportedCurrenciesBloc, SupportedCurrenciesState>(
            builder: (context, state) {
          if(state is Loading) {
            return const CircularProgressIndicator(backgroundColor: Colors.red,);
          }
          if(state is Loaded) {
            return MainContent(supportedCodes: state.supportedCurrencies.supportedCodes,);
          }
          if(state is Error) {
            return Text(state.message);
          }
          return GestureDetector(
            child: Container(padding: EdgeInsets.all(8),
            width: 150,
            height: 56,
            alignment: Alignment.center,
            color: Colors.green,
            child: Text("start", style: Theme.of(context).textTheme.headline4,),),
            onTap: (){
              BlocProvider.of<SupportedCurrenciesBloc>(context).add(GetSupportedCurrenciesEvent());
            },
          );

        }),
      ),
    );
  }
}
