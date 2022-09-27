

import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/home/presentation/widgets/supported_currencies_widget.dart';
import 'package:flutter/material.dart';

class MainContent extends StatefulWidget {

  final List<List<String>> supportedCodes;
  const MainContent({Key? key, required this.supportedCodes}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kContentPadding,
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Text("Supported Currencies", style: Theme.of(context).textTheme.headline5,),
            ],
          ),
          SizedBox(height: 16),
          SupportedCurrenciesWidget(supportedCodes: widget.supportedCodes),

        ],),
      ),
    );
  }
}
