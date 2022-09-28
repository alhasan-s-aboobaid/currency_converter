

import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/historical_data/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/home/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/conversions_content.dart';

class LatestConversionsPage extends StatefulWidget {
  final String currency;
  const LatestConversionsPage({Key? key, required this.currency}) : super(key: key);

  @override
  State<LatestConversionsPage> createState() => _LatestConversionsPageState();
}



class _LatestConversionsPageState extends State<LatestConversionsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      BlocProvider.of<LatestConversionsBloc>(context).add(GetLatestConversionsEvent(currency: widget.currency));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Last Conversions"),
      body: Container(padding: kPagePadding,
        child: BlocBuilder<LatestConversionsBloc, LatestConversionsState>(
            builder: (context, state) {
              if(state is Loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if(state is Loaded) {
                return ConversionsContent(latestData: state.latestData,);
              }
              if(state is Error) {
                return Text(state.message, style: Theme.of(context).textTheme.bodyText2,);
              }
              return Container();

            }),
      ),
    );
  }
}
