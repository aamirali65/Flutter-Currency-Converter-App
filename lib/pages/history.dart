import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:currensee/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Future<void> _deleteHistory() async {
    await FirebaseFirestore.instance
        .collection('conversion_history')
        .where('user_email', isEqualTo: currentUser?.email)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff182D9E),
        title: MyText('History', Colors.white, 18),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('conversion_history')
                .where('user_email', isEqualTo: currentUser?.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // If data is still loading, return a disabled icon button
                return IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete All History',
                );
              }
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                // If there are records in the conversion history, return an enabled icon button
                return IconButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Delete',
                      desc: 'Are you sure',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        _deleteHistory();
                      },
                    ).show();
                  },
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete All History',
                );
              } else {
                // If there are no records in the conversion history, return a disabled icon button
                return IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.delete),
                  tooltip: 'No History Found',
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('conversion_history')
              .where('user_email', isEqualTo: currentUser?.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No history available'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Card(
                  color: Color(0xff182D9E),
                  child: ListTile(
                    title: MyText('${data['amount']}', Colors.white, 18),
                    subtitle: MyText(
                      '${data['base_code']} to ${data['target_code']}',
                      Colors.white,
                      14,
                    ),
                    trailing: MyText(
                      '${(data['timestamp'] as Timestamp).toDate().toString()}',
                      Colors.white,
                      13,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
