import 'package:currency_converter/core/util/constants.dart';
import 'package:currency_converter/features/converter/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/converter/presentation/bloc/convert_currencies_bloc.dart';
import 'package:currency_converter/features/home/presentation/widgets/app_bar.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: kPagePadding,
        child: BlocBuilder<CurrencyConversionBloc, CurrencyConversionState>(builder: (context, state) {
          /*if(state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is Loaded) {
            return Text(state.conversionData.conversionResult.toString());
          }*/
          if (state is Error) {
            return Text(
              state.message,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2,
            );
          }
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Choose two currencies to convert between",
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("From", style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1),
                    SizedBox(
                      width: 64,
                      child: TextFormField(
                        validator: (value) {
                          if (value != null && value
                              .trim()
                              .length != 3) {
                            return 'This field requires 3 characters';
                          }
                          return null;
                        },
                        controller: fromController,
                        decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                    Text("To", style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1),
                    SizedBox(
                      width: 64,
                      child: TextFormField(
                        validator: (value) {
                          print(value);
                          if (value != null && value
                              .trim()
                              .length != 3) {
                            return 'This field requires 3 characters';
                          }
                          return null;
                        },
                        controller: toController,
                        decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),

                    Text("Amount", style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1),
                    SizedBox(
                      width: 64,
                      child: TextFormField(
                        validator: (value) {
                          print(value);
                          if (value == null) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                state is Loading ? CircularProgressIndicator() : SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 64,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        final bool isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          BlocProvider.of<CurrencyConversionBloc>(context).add(
                              ConvertBetweenCurrencies(from: fromController.text,
                                  to: toController.text, amount: int.parse(amountController.text)));
                        }
                      },
                      icon: const Icon(Icons.currency_exchange),
                      label: const Text('Convert')),
                ),
                const SizedBox(height: 30),
                state is Loaded ? Text(
                  "${amountController.text} ${fromController.text} = ${state.conversionData.conversionResult.toString()} "
                      "${toController.text}"
                  , style: Theme
                    .of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.green),) : SizedBox(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
