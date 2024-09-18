import 'package:currency_main/presentation/data_submit_page/data_submit.dart';
import 'package:currency_main/presentation/home_screen/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_main/application/provider/userprovider_currency.dart';
import 'package:currency_main/core/const.dart';
import 'package:currency_main/core/models/currency_model.dart';
import 'package:currency_main/presentation/home_screen/widgets/main_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCurrency = 'INR'; // Input currency
  String? _outputCurrency = 'USD'; // Output currency
  String _convertedValue = ''; // Holds the converted value

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProviderCurrency>(context, listen: false).getData();
    });
    super.initState();
  }

  // Function to handle currency conversion using API data
  void _convertCurrency(UserProviderCurrency provider) {
    double amount = double.tryParse(_amountController.text) ?? 0;

    // Fetch conversion rates from the provider
    double inputRate = provider.posts
            .firstWhere(
                (currency) => currency.currencyName == _selectedCurrency,
                orElse: () => CurrencyModel(
                    currencyNo: '',
                    currencyName: _selectedCurrency!,
                    currencyRates: '1',
                    permission: ''))
            .currencyRates
            .isNotEmpty
        ? double.parse(provider.posts
            .firstWhere(
                (currency) => currency.currencyName == _selectedCurrency)
            .currencyRates)
        : 1.0;

    double outputRate = provider.posts
            .firstWhere((currency) => currency.currencyName == _outputCurrency,
                orElse: () => CurrencyModel(
                    currencyNo: '',
                    currencyName: _outputCurrency!,
                    currencyRates: '1',
                    permission: ''))
            .currencyRates
            .isNotEmpty
        ? double.parse(provider.posts
            .firstWhere((currency) => currency.currencyName == _outputCurrency)
            .currencyRates)
        : 1.0;

    // Perform the conversion
    double convertedAmount = amount * (outputRate / inputRate);

    setState(() {
      _convertedValue =
          convertedAmount.toStringAsFixed(2); // Show 2 decimal points
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProviderCurrency>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background container
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),

          // Design container at the bottom
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * .3,
              width: size.width,
              color: Colors.white,
            ),
          ),

          // Main container for input and output
          Positioned(
            right: 20,
            left: 20,
            bottom: 70,
            child: MainContainer(
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 25, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Input area
                    Container(
                      height: 53,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: .5,
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          // TextField for entering the amount
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              width: size.width * .58,
                              child: TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _convertCurrency(
                                      provider); // Recalculate on amount change
                                },
                              ),
                            ),
                          ),

                          // Dropdown for selecting input currency
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: backgroundColor,
                              child: DropdownButton<String>(
                                value: _selectedCurrency,
                                isExpanded: true, // Avoid overflow
                                underline: const SizedBox.shrink(),
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                dropdownColor: backgroundColor,
                                items: provider.posts.map((currency) {
                                  return DropdownMenuItem(
                                    value: currency.currencyName,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(currency.currencyName),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCurrency = value;
                                    _convertCurrency(
                                        provider); // Recalculate on currency change
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Convert to',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Output area
                    Container(
                      height: 53,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: .5,
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Displaying the converted value
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              width: size.width * .58,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _convertedValue.isEmpty
                                    ? 'Result'
                                    : _convertedValue,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),

                          // Dropdown for selecting output currency
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: backgroundColor,
                              child: DropdownButton<String>(
                                value: _outputCurrency,
                                iconEnabledColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                isExpanded: true, // Avoid overflow
                                style: const TextStyle(color: Colors.white),
                                dropdownColor: backgroundColor,
                                items: provider.posts.map((currency) {
                                  return DropdownMenuItem(
                                    value: currency.currencyName,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(currency.currencyName),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _outputCurrency = value;
                                    _convertCurrency(
                                        provider); // Recalculate on currency change
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    //button
                    CustomButton(
                      size: size,
                      text: 'Next',
                      isIcon: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DataSubmit()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Heading text
          Positioned(
            top: size.height * .45,
            left: size.width * .27,
            child: const Text(
              'Currency Converter',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
