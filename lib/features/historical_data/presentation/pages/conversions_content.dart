
import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/historical_data/domain/entities/latest_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Last conversions for ${widget.latestData.baseCode}",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  "assets/icons/${widget.latestData.baseCode.substring(0, 2).toLowerCase()}.svg",
                  width: 48,
                  height: 32,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Last update ${widget.latestData.timeLastUpdateUtc.substring(0, 17)}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            const SizedBox(height: 16),

            GridView.count(crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
              ... widget.latestData.conversionRates.entries.map((e) {
                return Row(
                  children: [
                    Expanded(
                      child: SvgPicture.asset("assets/icons/${e.key.toLowerCase().substring(0,2)}.svg",
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(child: Text(e.value.toStringAsFixed(1).toString(), textAlign: TextAlign.center,)),
                  ],
                );
              })
            ],)
            
          ],
        ),
      ),
    );
  }

}
