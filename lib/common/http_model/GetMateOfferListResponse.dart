import 'package:pet_app/common/http_model/GetUserResponse.dart';

class GetMateOfferListResponse {
  final List<MateOfferResponse>? data;

  GetMateOfferListResponse({
    this.data,
  });

  GetMateOfferListResponse.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => MateOfferResponse.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList()};
}
