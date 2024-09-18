import 'package:currency_main/application/provider/userprovider_user.dart';
import 'package:currency_main/presentation/home_screen/widgets/custom_button.dart';
import 'package:currency_main/presentation/thanks%20page/thanks.dart';
import 'package:flutter/material.dart';
import 'package:currency_main/core/const.dart';
import 'package:currency_main/presentation/home_screen/widgets/main_container.dart';
import 'package:provider/provider.dart'; // Add this line for Provider

class DataSubmit extends StatefulWidget {
  const DataSubmit({super.key});

  @override
  State<DataSubmit> createState() => _DataSubmitState();
}

class _DataSubmitState extends State<DataSubmit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProviderDataSubmit>(context,
        listen: false); // Initialize the provider

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
              height: size.height * .36,
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
                      'Name',
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
                          // TextField for entering the name
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            width: size.width * .55,
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Email',
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
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            width: size.width * .55,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Submit Button
                    CustomButton(
                      size: size,
                      text: 'Submit',
                      isIcon: false,
                      onTap: () async {
                        // Call the addData function from the provider
                        await userProvider.addData(
                          _emailController.text.trim(),
                          _nameController.text.trim(),
                          context,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThanksPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Heading text
          Positioned(
            top: size.height * .46,
            left: size.width * .29,
            child: const Text(
              'Data Submitter',
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
