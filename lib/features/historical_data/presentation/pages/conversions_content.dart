

import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/historical_data/domain/entities/latest_data.dart';
import 'package:flutter/material.dart';

class ConversionsContent extends StatefulWidget {

  final LatestData latestData;
  const ConversionsContent({Key? key, required this.latestData}) : super(key: key);

  @override
  State<ConversionsContent> createState() => _ConversionsContentState();
}

class _ConversionsContentState extends State<ConversionsContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kContentPadding,
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Text("Last conversions for ${widget.latestData.baseCode}", style: Theme.of(context).textTheme.headline5,),
            ],
          ),
          Row(
            children: [
              Text("Last update ${widget.latestData.timeLastUpdateUtc.substring(0,17)}", style: Theme.of(context).textTheme.bodyText1,),
            ],
          ),
          SizedBox(height: 16),


        ],),
      ),
    );
  }
}
