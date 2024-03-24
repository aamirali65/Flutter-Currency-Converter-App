import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currensee/pages/faqs.dart';
import 'package:currensee/pages/feedback.dart';
import 'package:http/http.dart' as http;
import 'package:currensee/pages/history.dart';
import 'package:currensee/pages/login.dart';
import 'package:currensee/pages/news.dart';
import 'package:currensee/widgets/customText.dart';
import 'package:currensee/widgets/drawer_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? convertedResult;
  final auth = FirebaseAuth.instance;
  final List<String> items = [
  'AED',
    'ALL',
    'AFN',
    'AMD',
    'ANG',
    'AOA',
    'ARS',
    'AUD',
    'AWG',
    'AZN',
    'BAM',
    'BBD',
    'BDT',
    'BGN',
    'BHD',
    'BIF',
    'BMD',
    'BND',
    'BOB',
    'BRL',
    'BSD',
    'BTN',
    'BWP',
    'BYN',
    'BZD',
    'CAD',
    'CDF',
    'CHF',
    'CLP',
    'CNY',
    'COP',
    'CRC',
    'CUP',
    'CVE',
    'CZK',
    'DJF',
    'DKK',
    'DOP',
    'DZD',
    'EGP',
    'ERN',
    'ETB',
    'EUR',
    'FJD',
    'FKP',
    'FOK',
    'GBP',
    'GEL',
    'GGP',
    'GHS',
    'GIP',
    'GMD',
    'GNF',
    'GTQ',
    'GYD',
    'HKD',
    'HNL',
    'HRK',
    'HTG',
    'HUF',
    'IDR',
    'ILS',
    'IMP',
    'INR',
    'IQD',
    'IRR',
    'ISK',
    'JEP',
    'JMD',
    'JOD',
    'JPY',
    'KES',
    'KGS',
    'KHR',
    'KID',
    'KMF',
    'KRW',
    'KWD',
    'KYD',
    'KZT',
    'LAK',
    'LBP',
    'LKR',
    'LRD',
    'LSL',
    'LYD',
    'MAD',
    'MDL',
    'MGA',
    'MKD',
    'MMK',
    'MNT',
    'MOP',
    'MRU',
    'MUR',
    'MVR',
    'MWK',
    'MXN',
    'MYR',
    'MZN',
    'NAD',
    'NGN',
    'NIO',
    'NOK',
    'NPR',
    'NZD',
    'OMR',
    'PAB',
    'PEN',
    'PGK',
    'PHP',
    'PKR',
    'PLN',
    'PYG',
    'QAR',
    'RON',
    'RSD',
    'RUB',
    'RWF',
    'SAR',
    'SBD',
    'SCR',
    'SDG',
    'SEK',
    'SGD',
    'SHP',
    'SLE',
    'SOS',
    'SRD',
    'SSP',
    'STN',
    'SYP',
    'SZL',
    'THB',
    'TJS',
    'TMT',
    'TND',
    'TOP',
    'TRY',
    'TTD',
    'TVD',
    'TWD',
    'TZS',
    'UAH',
    'UGX',
    'USD',
    'UYU',
    'UZS',
    'VES',
    'VND',
    'VUV',
    'WST',
    'XAF',
    'XCD',
    'XDR',
    'XOF',
    'XPF',
    'YER',
    'ZAR',
    'ZMW',
    'ZWL',
  ];
  final List<String> items2 = [
    'AED',
    'ALL',
    'AFN',
    'AMD',
    'ANG',
    'AOA',
    'ARS',
    'AUD',
    'AWG',
    'AZN',
    'BAM',
    'BBD',
    'BDT',
    'BGN',
    'BHD',
    'BIF',
    'BMD',
    'BND',
    'BOB',
    'BRL',
    'BSD',
    'BTN',
    'BWP',
    'BYN',
    'BZD',
    'CAD',
    'CDF',
    'CHF',
    'CLP',
    'CNY',
    'COP',
    'CRC',
    'CUP',
    'CVE',
    'CZK',
    'DJF',
    'DKK',
    'DOP',
    'DZD',
    'EGP',
    'ERN',
    'ETB',
    'EUR',
    'FJD',
    'FKP',
    'FOK',
    'GBP',
    'GEL',
    'GGP',
    'GHS',
    'GIP',
    'GMD',
    'GNF',
    'GTQ',
    'GYD',
    'HKD',
    'HNL',
    'HRK',
    'HTG',
    'HUF',
    'IDR',
    'ILS',
    'IMP',
    'INR',
    'IQD',
    'IRR',
    'ISK',
    'JEP',
    'JMD',
    'JOD',
    'JPY',
    'KES',
    'KGS',
    'KHR',
    'KID',
    'KMF',
    'KRW',
    'KWD',
    'KYD',
    'KZT',
    'LAK',
    'LBP',
    'LKR',
    'LRD',
    'LSL',
    'LYD',
    'MAD',
    'MDL',
    'MGA',
    'MKD',
    'MMK',
    'MNT',
    'MOP',
    'MRU',
    'MUR',
    'MVR',
    'MWK',
    'MXN',
    'MYR',
    'MZN',
    'NAD',
    'NGN',
    'NIO',
    'NOK',
    'NPR',
    'NZD',
    'OMR',
    'PAB',
    'PEN',
    'PGK',
    'PHP',
    'PKR',
    'PLN',
    'PYG',
    'QAR',
    'RON',
    'RSD',
    'RUB',
    'RWF',
    'SAR',
    'SBD',
    'SCR',
    'SDG',
    'SEK',
    'SGD',
    'SHP',
    'SLE',
    'SOS',
    'SRD',
    'SSP',
    'STN',
    'SYP',
    'SZL',
    'THB',
    'TJS',
    'TMT',
    'TND',
    'TOP',
    'TRY',
    'TTD',
    'TVD',
    'TWD',
    'TZS',
    'UAH',
    'UGX',
    'USD',
    'UYU',
    'UZS',
    'VES',
    'VND',
    'VUV',
    'WST',
    'XAF',
    'XCD',
    'XDR',
    'XOF',
    'XPF',
    'YER',
    'ZAR',
    'ZMW',
    'ZWL',
  ];
  String? selectedValue;
  String? selectedValue2;
  final TextEditingController AmountEditingController = TextEditingController();
  final TextEditingController TotextEditingController = TextEditingController();
  final TextEditingController FromtextEditingController = TextEditingController();
  String? userEmail;
  String? userName;
  Future<void> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('user_email');
    if (userEmail != null) {
      FirebaseFirestore.instance.collection('users')
          .where('email', isEqualTo: userEmail)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          setState(() {
            userName = querySnapshot.docs[0]['username'];
            this.userEmail = userEmail;
          });
        }
      })
          .catchError((error) {
        print("Error getting user data: $error");
      });
    }
  }

  void saveConversionToFirestore(Map<String, dynamic> conversionData, double amount) async {
    if (userEmail != null) {
      FirebaseFirestore.instance.collection('conversion_history').add({
        'user_email': userEmail,
        'base_code': conversionData['base_code'],
        'target_code': conversionData['target_code'],
        'amount': amount,
        'conversion_result': conversionData['conversion_result'],
        'timestamp': DateTime.now(),
      });
    }
  }

  Future<void> convertCurrency(String baseCurrency, String targetCurrency, double amount) async {
    var url = 'https://v6.exchangerate-api.com/v6/535d6913da28f3252e2fd68c/pair/$baseCurrency/$targetCurrency/$amount';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var conversionData = {
        'base_code': data['base_code'],
        'target_code': data['target_code'],
        'amount': amount,
        'conversion_result': data['conversion_result'],
      };

      // Update the result container
      setState(() {
        convertedResult = conversionData['conversion_result'].toString();
        saveConversionToFirestore(conversionData, amount);
      });
    } else {
      print('Failed to load data: ${response.reasonPhrase}');
    }
  }
  @override
  void initState() {
    super.initState();
    getUserEmail();
  }

  @override
  void dispose() {
    FromtextEditingController.dispose();
    TotextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        title: MyText('CurrenSee', Colors.white, 18),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff182D9E),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xff182D9E),
                    ),
                    accountName: MyText(userName ?? '', Colors.white, 25),
                    accountEmail: MyText(userEmail ?? '', Colors.white, 15),
                  ),
                  const SizedBox(height: 20),
                  // drawerList('Home', Icons.home, () {
                  //   Navigator.pop(context);
                  // }),
                  drawerList('History', Icons.history, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const History(),));
                  }),
                  drawerList('News', Icons.stacked_line_chart, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsPage(),));
                  }),
                  drawerList('FeedBack', Icons.feedback, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedBack(),));
                  }),
                  drawerList('FAQs', Icons.question_mark, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FAQs(),));
                  }),


                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: drawerList('Log out', Icons.logout_outlined, () {
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  });
                })),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.width * 0.50,
            child: const Image(image: AssetImage('assets/images/bg.jpg')),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    MyText('Amount :', const Color(0xff182D9E), 20),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: AmountEditingController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xff182D9E)),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xff182D9E)),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xff182D9E)),
                              borderRadius: BorderRadius.circular(30))),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('From', const Color(0xff182D9E), 19),
                        DropdownButtonHideUnderline(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                height: 40,
                                // Remove width here
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: FromtextEditingController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: FromtextEditingController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Search for an item...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .contains(searchValue);
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  FromtextEditingController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          String? temp = selectedValue;
                          selectedValue = selectedValue2;
                          selectedValue2 = temp;
                        });
                      },
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xff182D9E),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.swap_horiz,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('To', const Color(0xff182D9E), 19),
                        DropdownButtonHideUnderline(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items2
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue2,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue2 = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                height: 40,
                                // Remove width here
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: TotextEditingController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: TotextEditingController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Search for an item...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .contains(searchValue);
                                },
                              ),
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  TotextEditingController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xffD3D9E7),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Result : ',
                        style: TextStyle(
                            color: Color(0xff182D9E),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lexend',
                            fontSize: 20),
                      ),
                      Text(
                        convertedResult ?? '',
                        style: const TextStyle(
                            color: Color(0xff182D9E),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Lexend',
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    // Call the API to convert currencies
                    double amount = double.parse(AmountEditingController.text);
                    await convertCurrency(selectedValue!, selectedValue2!, amount);
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xff182D9E),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                          child: Text(
                        'CONVERT',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lexend',
                            fontSize: 18),
                      ))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
