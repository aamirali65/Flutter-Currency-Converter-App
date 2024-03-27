import 'package:accordion/controllers.dart';
import 'package:currensee/services/connection.dart';
import 'package:currensee/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 14, fontWeight: FontWeight.bold);
  static const contentStyle = TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal);
   final double padding = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        title: MyText('FAQs', Colors.white, 18),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          InternetConnection(),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                  children: [
                    const Text('FAQs',style: TextStyle(fontSize: 30,fontFamily: 'Lexend',fontWeight: FontWeight.w600),),
                    Accordion(
                      headerBorderColor: const Color(0xff182D9E),
                      headerBorderColorOpened: const Color(0xff182D9E),
                      headerBackgroundColorOpened: const Color(0xff182D9E),
                      contentBackgroundColor: const Color(0xff182D9E),
                      headerBackgroundColor: const Color(0xff182D9E),
                      contentBorderWidth: 0,
                      contentHorizontalPadding: 10,
                      scaleWhenAnimating: false,
                      openAndCloseAnimation: false,
                      headerPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: [
                        AccordionSection(
                          isOpen: false,
                          contentVerticalPadding: padding,
                          leftIcon:
                          const Icon(Icons.question_mark, color: Colors.white),
                          header: const Text('How do I create an account in CurrenSee?', style: headerStyle),
                          content: const Text("To create an account, simply navigate to the registration page within the app and follow the prompts. You'll need to provide some basic information and choose a secure password.",
                              style: contentStyle),
                        ),
                        AccordionSection(
                          isOpen: false,
                          contentVerticalPadding: padding,
                          leftIcon:
                          const Icon(Icons.question_mark, color: Colors.white),
                          header: const Text('Can I log in using my social media accounts?', style: headerStyle),
                          content: const Text("Yes, CurrenSee offers social media login options for added convenience and security.",
                              style: contentStyle),
                        ),
                        AccordionSection(
                          isOpen: false,
                          contentVerticalPadding: padding,
                          leftIcon:
                          const Icon(Icons.question_mark, color: Colors.white),
                          header: const Text('How accurate are the exchange rates provided by CurrenSee?', style: headerStyle),
                          content: const Text('CurrenSee fetches real-time exchange rates from reliable sources to ensure accuracy. However, please note that exchange rates may fluctuate due to market conditions.',
                              style: contentStyle),
                        ),
                        AccordionSection(
                          isOpen: false,
                          contentVerticalPadding: padding,
                          leftIcon:
                          const Icon(Icons.question_mark, color: Colors.white),
                          header: const Text('How can I access my currency conversion history?', style: headerStyle),
                          content: const Text("Your currency conversion history is accessible within the app. Simply navigate to the transaction history section to view past conversion details, including dates, rates, and amounts.",
                              style: contentStyle),
                        ),
                        AccordionSection(
                          isOpen: false,
                          contentVerticalPadding: padding,
                          leftIcon:
                          const Icon(Icons.question_mark, color: Colors.white),
                          header: const Text('Where can I find currency news and market trends on CurrenSee?', style: headerStyle),
                          content: const Text("CurrenSee offers a dedicated section for currency news and market analysis. You can stay updated on the latest developments and trends in the foreign exchange market.",
                              style: contentStyle),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          )
        ],
      )
    );
  }
}
