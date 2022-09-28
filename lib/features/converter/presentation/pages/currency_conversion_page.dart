import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/converter/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/converter/presentation/widgets/entry_field.dart';
import 'package:currency_converter/features/home/presentation/widgets/app_bar.dart';
import 'package:currency_converter/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({Key? key}) : super(key: key);

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController fromController = TextEditingController(text: "USD");
  TextEditingController toController = TextEditingController(text: "SYP");
  TextEditingController amountController = TextEditingController(text: "1");
  CurrencyConversionBloc bloc = CurrencyConversionBloc(convertCurrencies: inj());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Currencies Converter"),
      body: Container(
        padding: kPagePadding,
        child: BlocBuilder<CurrencyConversionBloc, CurrencyConversionState>(
          bloc: bloc,
            builder: (context, state) {
          if (state is Error) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
          }
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Choose two currencies to convert between",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("From", style: Theme.of(context).textTheme.bodyText1),
                    EntryField(textEditingController: fromController, inputType: INPUT_TYPE.text,),
                    Text("To", style: Theme.of(context).textTheme.bodyText1),
                    EntryField(textEditingController: toController, inputType: INPUT_TYPE.text),
                    Text("Amount", style: Theme.of(context).textTheme.bodyText1),
                    EntryField(textEditingController: amountController, inputType: INPUT_TYPE.number)
                  ],
                ),
                const SizedBox(height: 30),
                state is Loading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              final bool isValid = _formKey.currentState!.validate();
                              if (isValid) {
                                bloc.add(ConvertBetweenCurrencies(
                                    from: fromController.text,
                                    to: toController.text,
                                    amount: int.parse(amountController.text)));
                              }
                            },
                            icon: const Icon(Icons.currency_exchange),
                            label: const Text('Convert')),
                      ),
                const SizedBox(height: 30),
                state is Loaded
                    ? Text(
                        "${amountController.text} ${fromController.text} = ${state.conversionData.conversionResult.toString()} "
                        "${toController.text}",
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.green),
                      )
                    : SizedBox(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
