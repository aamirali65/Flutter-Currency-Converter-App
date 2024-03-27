import 'package:currensee/services/connection.dart';
import 'package:currensee/widgets/customText.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  List<bool> _starStates = List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        title: MyText('FeedBack', Colors.white, 18),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          InternetConnection(),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Give feedback',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,fontFamily: 'Lexend'),),
                      const SizedBox(height: 40,),
                      const Text('How did we do ?',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,fontFamily: 'Lexend')),
                      const SizedBox(height: 10,),
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            onPressed: () {
                              setState(() {
                                _starStates[index] = !_starStates[index];
                              });
                            },
                            icon: Icon(
                              _starStates[index] ? Icons.star : Icons.star_border_outlined,
                              size: 45,
                              color: _starStates[index] ? Colors.yellow : null,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 40,),
                      const Text('Care to share more about it?',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,fontFamily: 'Lexend')),
                      const SizedBox(height: 10,),
                      const TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Type your feedback here...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Color(0xff182D9E),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(child: Text('PUBLIC FEEDBACK',style: TextStyle(fontFamily: 'Lexend',fontWeight: FontWeight.w500,color: Colors.white),)),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}