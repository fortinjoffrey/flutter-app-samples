import 'package:job_board_app/models/job_offer_model.dart';

abstract class DummyData {
  static const List<JobOfferModel> jobOffers = [
    JobOfferModel(title: 'Fullstack developer'),
    JobOfferModel(title: 'Tech lead'),
    JobOfferModel(title: 'Flutter developer'),
    JobOfferModel(title: 'Java expert'),
    JobOfferModel(title: 'Back-end software engineer'),
    JobOfferModel(title: 'Vue.js developer'),
  ];
}
