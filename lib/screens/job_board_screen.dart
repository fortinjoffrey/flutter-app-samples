import 'package:flutter/material.dart';
import 'package:job_board_app/data/dummy_data.dart';
import 'package:job_board_app/models/job_offer_model.dart';

class JobBoardScreen extends StatelessWidget {
  const JobBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job board'),
      ),
      body: ListView.builder(
        itemCount: DummyData.jobOffers.length,
        itemBuilder: (context, index) {
          final JobOfferModel jobOffer = DummyData.jobOffers[index];
          return ListTile(
            title: Text(jobOffer.title),
          );
        },
      ),
    );
  }
}
