import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/data/models/questions_model.dart';
import 'package:quiz_app/utils/constants.dart';

class QuestionsRepository {
  final List<QuestionModel> _questions = [];

  Future<Either<String, List<QuestionModel>>> fetchQuestions() async {
    _questions.clear();
    try {
      final _response = await http.get(Uri.parse('$kBaseUrl/questions.json'));
      final _responseDecoded = jsonDecode(_response.body);
      if (_response.statusCode == 200) {
        final _data = _responseDecoded
            .map((e) => QuestionModel.fromMap(e as Map<String, dynamic>))
            .toList();

        _data.forEach((element) {
          _questions.add(element as QuestionModel);
        });
      }
    } on http.ClientException {
      return const Left('Erro no cliente HTTP');
    } on SocketException {
      return const Left('Sem conexão com a internet');
    } on Exception {
      return const Left('Erro ao tentar buscar as questões');
    }
    return Right(_questions);
  }
}
