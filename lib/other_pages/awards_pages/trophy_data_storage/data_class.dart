import 'package:json_annotation/json_annotation.dart';

// json methods generated using code geneartion
// see https://flutter.dev/docs/development/data-and-backend/json#serializing-json-using-code-generation-libraries
part 'data_class.g.dart';

@JsonSerializable()
class DataClass {
  List<int> trophies;

  DataClass({required this.trophies});

  //use this to get one property
  int get(int index) {
    return trophies[index];
  }

  // run the following command to generate json:
  // flutter pub run build_runner build
  factory DataClass.fromJson(Map<String, dynamic> json) =>
      _$DataClassFromJson(json);

  Map<String, dynamic> toJson() => _$DataClassToJson(this);
}
