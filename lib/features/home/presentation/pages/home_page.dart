
import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/home/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/home/presentation/widgets/app_bar.dart';
import 'package:currency_converter/features/home/presentation/widgets/main_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SupportedCurrenciesPage extends StatefulWidget {
  const SupportedCurrenciesPage({Key? key}) : super(key: key);

  @override
  State<SupportedCurrenciesPage> createState() => _SupportedCurrenciesPageState();
}

class _SupportedCurrenciesPageState extends State<SupportedCurrenciesPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      BlocProvider.of<SupportedCurrenciesBloc>(context).add(GetSupportedCurrenciesEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Supported currencies"),
      body: Container(
        padding: kPagePadding,
        child: BlocBuilder<SupportedCurrenciesBloc, SupportedCurrenciesState>(
            builder: (context, state) {
          if(state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is Loaded) {
            return MainContent(supportedCodes: state.supportedCurrencies.supportedCodes,);
          }
          if(state is Error) {
            return Text(state.message, style: Theme.of(context).textTheme.bodyText2,);
          }
          return Container(); /*GestureDetector(
            child: Container(padding: EdgeInsets.all(8),
            width: 150,
            height: 56,
            alignment: Alignment.center,
            color: Colors.green,
            child: Text("start", style: Theme.of(context).textTheme.headline4,),),
            onTap: (){
              BlocProvider.of<SupportedCurrenciesBloc>(context).add(GetSupportedCurrenciesEvent());
            },
          )*/;

        }),
      ),
    );
  }
}
