import 'package:currency_converter/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportedCurrenciesWidget extends StatefulWidget {
  final List<List<String>> supportedCodes;

  const SupportedCurrenciesWidget({Key? key, required this.supportedCodes}) : super(key: key);

  @override
  State<SupportedCurrenciesWidget> createState() => _SupportedCurrenciesWidgetState();
}

class _SupportedCurrenciesWidgetState extends State<SupportedCurrenciesWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
        childAspectRatio: 3),
        itemCount: widget.supportedCodes.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'latest', arguments: {
                'currency': widget.supportedCodes[index][0]
              });
            },
            child: Container(
              margin: kMargin,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1)),
              child: Row(
                children: [
                  Expanded(
                    child: SvgPicture.asset("assets/icons/${widget.supportedCodes[index][0].toLowerCase().substring(0,2)}.svg",
                      height: 48,
                      fit: BoxFit.cover,
                      placeholderBuilder: (ctx) {
                      return Container(
                        color: Colors.grey,
                        child: Text('loading', style: Theme.of(context).textTheme.bodySmall,),
                      );
                      },
                    ),
                  ),
                  Expanded(child: Text(widget.supportedCodes[index][0], textAlign: TextAlign.center,)),
                ],
              ),
            ),
          );
        });
  }
}
