// lib/features/tests/data/mock_tests.dart
import '../domain/entities/test.dart';

/// Тестүүдийн жагсаалт
final List<TestInfo> mockTests = [
  const TestInfo(
    id: 'riasec',
    title: 'RIASEC Career Test',
    description: 'Өөрт тохирох мэргэжлээ олоход туслах стандарт тест',
    icon: '🎯',
    questionCount: 30,
    durationMinutes: 7,
    isPremium: false,
  ),
  const TestInfo(
    id: 'personality',
    title: 'Зан чанарын тест',
    description: 'Таны зан төлөв, хувийн шинж чанарыг илрүүлнэ',
    icon: '🧠',
    questionCount: 25,
    durationMinutes: 5,
    isPremium: false,
  ),
  const TestInfo(
    id: 'skills',
    title: 'Ур чадварын үнэлгээ',
    description: 'Таны давуу тал, сул талыг тодорхойлно',
    icon: '⚡',
    questionCount: 35,
    durationMinutes: 10,
    isPremium: true,
  ),
  const TestInfo(
    id: 'career_deep',
    title: 'Career Deep-Fit Analysis',
    description: 'Нарийвчилсан карьерын дүн шинжилгээ болон зөвлөмж',
    icon: '🎓',
    questionCount: 50,
    durationMinutes: 15,
    isPremium: true,
  ),
  const TestInfo(
    id: 'values',
    title: 'Үнэт зүйлсийн тест',
    description: 'Танд юу хамгийн чухал болохыг тодорхойлно',
    icon: '💎',
    questionCount: 20,
    durationMinutes: 5,
    isPremium: false,
  ),
];
