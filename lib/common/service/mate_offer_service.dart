
// import 'package:get/get.dart';

// import 'package:pet_app/common/common.dart';
// import 'package:pet_app/common/http_model/GetUserResponse.dart';
// import 'package:pet_app/common/service/http_service_manager.dart';

// class MateOfferService {

//  static final MateOfferService _instance = MateOfferService._internal();

//   static MateOfferService get instance => Get.find<MateOfferService>();

//   factory MateOfferService() => _instance;
//   MateOfferService._internal() {
//     Common.logger.d('MateOfferService._internal() called!!!');
//   }

//   Rxn<MateOfferResponse
//   Future<bool> getMateOfferListResponse() async {
//     var res = await HttpServiceManager().getUserPrefer();
//     if (res.result) {
//       setMyMateOffer(p: res.value);
//     }
//     return res.result;
//   }

//   Future<bool> updateUserPrefer(Map data, bool isInit) async {
//     var res = await HttpServiceManager().userPreferUpdate(data: data, isInit: isInit);
//     if (res.result) {
//       setUserDetails(p: res.value);
//     }
//     return res.result;
//   }

//   //MateOffer
// getMateOfferListResponse

// }