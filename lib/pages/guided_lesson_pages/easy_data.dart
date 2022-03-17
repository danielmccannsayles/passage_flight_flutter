import 'package:json_annotation/json_annotation.dart';

// json methods generated using code geneartion
// see https://flutter.dev/docs/development/data-and-backend/json#serializing-json-using-code-generation-libraries
part 'easy_data.g.dart';

@JsonSerializable()
class EasyData {
  int mathOne = 0;
  int scienceOne = 0;

  EasyData(this.mathOne, this.scienceOne);

  //low budget version of what the fromjson and tojson do. Easier to understand,
  //and less annoying to deal w/ recompiling L O L.
  Map<String, dynamic> toMap() {
    return {
      'mathOne': mathOne,
      'scienceOne': scienceOne,
    };
  }

  // run the following command to generate json:
  // flutter pub run build_runner build
  factory EasyData.fromJson(Map<String, dynamic> json) =>
      _$EasyDataFromJson(json);

  Map<String, dynamic> toJson() => _$EasyDataToJson(this);
}
