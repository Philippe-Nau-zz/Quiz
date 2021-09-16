class QuestionModel {
  final int id;
  final List<int> answer;
  final List<bool> answered;
  final String question;
  final List<String> options;
  final String answerExplanation;

  QuestionModel({
    this.id,
    this.question,
    this.answer,
    this.answered,
    this.options,
    this.answerExplanation,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    final List<bool> _answered = [];
    final _options = List<String>.from(map['options'] as List<dynamic>);

    for (var i = 0; i < _options.length; i++) {
      _answered.add(
        false,
      );
    }

    return QuestionModel(
      id: map['id'] as int,
      answer: List<int>.from(map['answer_index'] as List<dynamic>),
      answered: _answered,
      question: map['question'] as String,
      options: _options,
      answerExplanation: map['answer_explanation'] as String,
    );
  }
}
