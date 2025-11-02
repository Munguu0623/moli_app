// lib/features/tests/application/test_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../domain/entities/test_question.dart';
import '../domain/entities/test_result.dart';
import '../data/mock_questions.dart';

/// Тестийн асуултууд
final testQuestionsProvider = Provider<List<TestQuestion>>((ref) {
  return mockTestQuestions;
});

/// Одоогийн асуултын индекс
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

/// Хэрэглэгчийн хариултууд
final testAnswersProvider =
    StateNotifierProvider<TestAnswersNotifier, Map<String, int>>((ref) {
      return TestAnswersNotifier();
    });

class TestAnswersNotifier extends StateNotifier<Map<String, int>> {
  TestAnswersNotifier() : super({});

  void saveAnswer(String questionId, int value) {
    state = {...state, questionId: value};
  }

  void reset() {
    state = {};
  }

  int? getAnswer(String questionId) {
    return state[questionId];
  }
}

/// Тестийн явц (хувь)
final testProgressProvider = Provider<double>((ref) {
  final answers = ref.watch(testAnswersProvider);
  final totalQuestions = ref.watch(testQuestionsProvider).length;
  return answers.length / totalQuestions;
});

/// Тестийн дууссан эсэх
final isTestCompletedProvider = Provider<bool>((ref) {
  final answers = ref.watch(testAnswersProvider);
  final totalQuestions = ref.watch(testQuestionsProvider).length;
  return answers.length == totalQuestions;
});

/// Тестийн үр дүн тооцоолох
final testResultProvider = Provider<TestResult?>((ref) {
  final answers = ref.watch(testAnswersProvider);
  final questions = ref.watch(testQuestionsProvider);
  final isCompleted = ref.watch(isTestCompletedProvider);

  if (!isCompleted) return null;

  // RIASEC категори бүрийн оноог тооцоолох
  final scores = <String, int>{'R': 0, 'I': 0, 'A': 0, 'S': 0, 'E': 0, 'C': 0};

  for (final question in questions) {
    final answer = answers[question.id];
    if (answer != null) {
      scores[question.category] = (scores[question.category] ?? 0) + answer;
    }
  }

  // Code үүсгэх (хамгийн өндөр 3)
  final code = TestResult.calculateCode(scores);

  // Traits тодорхойлох
  final traits = _getTraitsForCode(code);

  // Тохирох мэргэжлүүд (одоогоор mock)
  final recommendedCareerIds = _getRecommendedCareers(code);

  return TestResult(
    code: code,
    scores: scores,
    traits: traits,
    recommendedCareerIds: recommendedCareerIds,
  );
});

/// Code-д тохирох шинж чанарууд
List<String> _getTraitsForCode(String code) {
  final Map<String, List<String>> categoryTraits = {
    'R': ['Практик', 'Бие махбодийн ажил', 'Техник чадвартай'],
    'I': ['Шинжлэгч', 'Сонирхолтой', 'Дүн шинжилгээ сайтай'],
    'A': ['Бүтээлч', 'Уран сайхны мэдрэмжтэй', 'Өөрийн гэсэн хэв маяг'],
    'S': ['Хүмүүст тусалдаг', 'Баг хамт олонтой', 'Харилцаа сайтай'],
    'E': ['Манлайлагч', 'Бизнес чиглэлтэй', 'Идэвхтэй'],
    'C': ['Зохион байгуулалттай', 'Нарийвчлалтай', 'Хариуцлагатай'],
  };

  final traits = <String>[];
  for (int i = 0; i < code.length && i < 3; i++) {
    final category = code[i];
    final categoryTraitsList = categoryTraits[category] ?? [];
    if (categoryTraitsList.isNotEmpty) {
      traits.add(categoryTraitsList[i % categoryTraitsList.length]);
    }
  }

  return traits;
}

/// Code-д тохирох мэргэжлүүд (mock)
List<String> _getRecommendedCareers(String code) {
  // TODO: Domain entities-тэй холбох
  final Map<String, List<String>> codeCareerMap = {
    'R': ['engineer', 'mechanic', 'electrician'],
    'I': ['scientist', 'researcher', 'analyst'],
    'A': ['designer', 'artist', 'writer'],
    'S': ['teacher', 'counselor', 'nurse'],
    'E': ['manager', 'entrepreneur', 'sales'],
    'C': ['accountant', 'administrator', 'banker'],
  };

  final careers = <String>{};
  for (int i = 0; i < code.length; i++) {
    final category = code[i];
    careers.addAll(codeCareerMap[category] ?? []);
  }

  return careers.take(5).toList();
}
