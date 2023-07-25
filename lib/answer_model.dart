import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_model.g.dart';
part 'answer_model.freezed.dart';

@Freezed()
class Answer with _$Answer {
  const factory Answer({
    @JsonKey(name: 'id') required int id,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
