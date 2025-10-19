// lib/features/advisors/data/mock_advisors.dart

import '../domain/models/advisor.dart';
import '../domain/models/chat_message.dart';

/// Mock зөвлөхүүдийн жагсаалт
final List<Advisor> mockAdvisors = [
  Advisor(
    id: 'adv_001',
    name: 'Батзаяа',
    title: 'МУИС - IT багш',
    imageUrl: 'https://i.pravatar.cc/150?img=33',
    expertise: [AdvisorExpertise.career, AdvisorExpertise.major],
    rating: 4.9,
    reviewCount: 45,
    bio:
        'IT салбарт 12 жил ажилласан туршлагатай. Мэдээллийн технологийн чиглэлээр суралцахыг хүсч буй оюутнуудад зөвлөгөө өгдөг. МУИС-ийн Компьютерийн Ухааны тэнхимд ахлах багшаар ажиллаж байна.',
    experienceYears: 12,
    languages: ['Монгол', 'English'],
    verified: true,
    pricing: {ConsultationType.chat: 5000, ConsultationType.video: 10000},
    availableSlots: _generateSlots(DateTime.now(), [10, 14, 16, 18]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_002',
    name: 'Энхжин',
    title: 'Санхүүгийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=47',
    expertise: [AdvisorExpertise.scholarship, AdvisorExpertise.university],
    rating: 4.8,
    reviewCount: 32,
    bio:
        'Олон улсын тэтгэлгийн талаар мэргэшсэн зөвлөх. АНУ, Канад, Европын сургуулиудад элсэх болон тэтгэлэг авах талаар 200 гаруй оюутанд амжилттай зөвлөгөө өгсөн.',
    experienceYears: 8,
    languages: ['Монгол', 'English'],
    verified: true,
    pricing: {ConsultationType.chat: 10000, ConsultationType.video: 15000},
    availableSlots: _generateSlots(DateTime.now(), [9, 13, 15, 17]),
    isAvailableToday: false,
  ),
  Advisor(
    id: 'adv_003',
    name: 'Болд',
    title: 'Анагаахын их сургууль - Багш',
    imageUrl: 'https://i.pravatar.cc/150?img=12',
    expertise: [AdvisorExpertise.major, AdvisorExpertise.career],
    rating: 5.0,
    reviewCount: 28,
    bio:
        'Анагаахын салбарт 15 жил ажилласан эмч, багш. Анагаах ухааны чиглэлээр суралцах сонирхолтой оюутнуудад мэргэжлийн зөвлөгөө өгдөг.',
    experienceYears: 15,
    languages: ['Монгол'],
    verified: true,
    pricing: {ConsultationType.chat: 0, ConsultationType.video: 8000},
    availableSlots: _generateSlots(DateTime.now(), [11, 14, 16]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_004',
    name: 'Сарантуяа',
    title: 'Карьерийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=38',
    expertise: [AdvisorExpertise.career, AdvisorExpertise.other],
    rating: 4.7,
    reviewCount: 56,
    bio:
        'Олон улсын томоохон компаниудад HR менежерээр ажилласан. Карьерийн төлөвлөлт, CV бэлтгэх, ярилцлагад бэлтгэх талаар зөвлөгөө өгдөг.',
    experienceYears: 10,
    languages: ['Монгол', 'English'],
    verified: true,
    pricing: {ConsultationType.chat: 7000, ConsultationType.video: 12000},
    availableSlots: _generateSlots(DateTime.now(), [10, 12, 14, 16, 18]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_005',
    name: 'Ганбат',
    title: 'Инженерийн их сургууль - Профессор',
    imageUrl: 'https://i.pravatar.cc/150?img=51',
    expertise: [AdvisorExpertise.university, AdvisorExpertise.major],
    rating: 4.9,
    reviewCount: 41,
    bio:
        'Инженерийн салбарт 20 жил ажилласан профессор. Механик, цахилгаан, барилгын инженерчлэлийн чиглэлээр зөвлөгөө өгдөг.',
    experienceYears: 20,
    languages: ['Монгол', 'English', 'Орос'],
    verified: true,
    pricing: {ConsultationType.chat: 5000, ConsultationType.video: 10000},
    availableSlots: _generateSlots(
      DateTime.now().add(const Duration(days: 1)),
      [9, 11, 14],
    ),
    isAvailableToday: false,
  ),
  Advisor(
    id: 'adv_006',
    name: 'Нарантуяа',
    title: 'Урлагийн их сургууль - Багш',
    imageUrl: 'https://i.pravatar.cc/150?img=45',
    expertise: [AdvisorExpertise.major, AdvisorExpertise.career],
    rating: 4.8,
    reviewCount: 23,
    bio:
        'Дүрслэх урлаг, дизайны салбарт мэргэшсэн. Урлаг, дизайны чиглэлээр суралцах хүсэлтэй залуучуудад зөвлөгөө өгдөг.',
    experienceYears: 9,
    languages: ['Монгол'],
    verified: true,
    pricing: {ConsultationType.chat: 0, ConsultationType.video: 0},
    availableSlots: _generateSlots(DateTime.now(), [13, 15, 17]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_007',
    name: 'Мөнхбаяр',
    title: 'Бизнесийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=68',
    expertise: [AdvisorExpertise.career, AdvisorExpertise.university],
    rating: 4.6,
    reviewCount: 38,
    bio:
        'Бизнес удирдлага, менежментийн салбарт туршлагатай. Бизнес, эдийн засгийн чиглэлээр суралцах сонирхолтой оюутнуудад зөвлөдөг.',
    experienceYears: 11,
    languages: ['Монгол', 'English'],
    verified: false,
    pricing: {ConsultationType.chat: 8000, ConsultationType.video: 15000},
    availableSlots: _generateSlots(
      DateTime.now().add(const Duration(days: 2)),
      [10, 14, 16],
    ),
    isAvailableToday: false,
  ),
  Advisor(
    id: 'adv_008',
    name: 'Оюунaa',
    title: 'Хууль зүйн их сургууль - Багш',
    imageUrl: 'https://i.pravatar.cc/150?img=20',
    expertise: [AdvisorExpertise.major, AdvisorExpertise.career],
    rating: 4.9,
    reviewCount: 34,
    bio:
        'Хууль зүйн салбарт 14 жил ажилласан хуульч, багш. Хууль зүйн мэргэжлээр суралцах хүсэлтэй оюутнуудад зөвлөгөө өгдөг.',
    experienceYears: 14,
    languages: ['Монгол', 'English'],
    verified: true,
    pricing: {ConsultationType.chat: 6000, ConsultationType.video: 11000},
    availableSlots: _generateSlots(DateTime.now(), [9, 11, 15, 17]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_009',
    name: 'Тэмүүлэн',
    title: 'Startup зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=58',
    expertise: [AdvisorExpertise.career, AdvisorExpertise.other],
    rating: 4.7,
    reviewCount: 29,
    bio:
        'Технологийн startup компаниуд үүсгэж, олон жил ажилласан туршлагатай. Бизнес эрхлэх, технологийн чиглэлээр суралцах сонирхолтой залуучуудад зөвлөдөг.',
    experienceYears: 7,
    languages: ['Монгол', 'English'],
    verified: false,
    pricing: {ConsultationType.chat: 10000, ConsultationType.video: 18000},
    availableSlots: _generateSlots(
      DateTime.now().add(const Duration(days: 1)),
      [14, 16, 18],
    ),
    isAvailableToday: false,
  ),
  Advisor(
    id: 'adv_010',
    name: 'Ууганбаяр',
    title: 'ШУТИС - Багш',
    imageUrl: 'https://i.pravatar.cc/150?img=14',
    expertise: [AdvisorExpertise.university, AdvisorExpertise.scholarship],
    rating: 4.8,
    reviewCount: 42,
    bio:
        'Олон улсын харилцаа, дипломат албаны чиглэлээр мэргэшсэн. ШУТИС-д багшаар ажиллаж, олон улсын тэтгэлгийн талаар зөвлөдөг.',
    experienceYears: 13,
    languages: ['Монгол', 'English', 'Орос'],
    verified: true,
    pricing: {ConsultationType.chat: 7000, ConsultationType.video: 13000},
    availableSlots: _generateSlots(DateTime.now(), [10, 13, 15]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_011',
    name: 'Алтанцэцэг',
    title: 'Сургуулийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=43',
    expertise: [AdvisorExpertise.career, AdvisorExpertise.major],
    rating: 4.9,
    reviewCount: 51,
    bio:
        'Боловсролын салбарт 16 жил ажилласан туршлагатай зөвлөх. Ахлах ангийн сурагчдад карьерийн чиглэл сонгоход нь туслана.',
    experienceYears: 16,
    languages: ['Монгол'],
    verified: true,
    pricing: {ConsultationType.chat: 0, ConsultationType.video: 5000},
    availableSlots: _generateSlots(DateTime.now(), [11, 14, 16, 18]),
    isAvailableToday: true,
  ),
  Advisor(
    id: 'adv_012',
    name: 'Дорж',
    title: 'Tech компанийн захирал',
    imageUrl: 'https://i.pravatar.cc/150?img=56',
    expertise: [AdvisorExpertise.career, AdvisorExpertise.major],
    rating: 5.0,
    reviewCount: 37,
    bio:
        'Технологийн томоохон компанид захиралаар ажилладаг. IT, программ хангамж, бизнес технологийн чиглэлээр зөвлөгөө өгдөг.',
    experienceYears: 18,
    languages: ['Монгол', 'English'],
    verified: true,
    pricing: {ConsultationType.chat: 12000, ConsultationType.video: 20000},
    availableSlots: _generateSlots(
      DateTime.now().add(const Duration(days: 3)),
      [15, 17],
    ),
    isAvailableToday: false,
  ),
];

/// Mock үнэлгээнүүд
final Map<String, List<AdvisorReview>> mockReviews = {
  'adv_001': [
    AdvisorReview(
      id: 'rev_001',
      studentName: 'Мөнхбат',
      rating: 5,
      comment:
          'IT мэргэжлийн талаар маш их мэдээлэл авсан. Туслалцаа маш сайн байсан!',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AdvisorReview(
      id: 'rev_002',
      studentName: 'Ханд',
      rating: 5,
      comment: 'Карьерийн зөвлөгөө маш хэрэгтэй байлаа. Баярлалаа!',
      date: DateTime.now().subtract(const Duration(days: 12)),
    ),
    AdvisorReview(
      id: 'rev_003',
      studentName: 'Наран',
      rating: 4,
      comment: 'Сайн зөвлөгөө өгсөн. Цаашид дахин хандах болно.',
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ],
  'adv_002': [
    AdvisorReview(
      id: 'rev_004',
      studentName: 'Ариунаа',
      rating: 5,
      comment: 'Тэтгэлгийн талаар бүх зүйлийг маш ойлгомжтой тайлбарласан!',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    AdvisorReview(
      id: 'rev_005',
      studentName: 'Бат-Эрдэнэ',
      rating: 4,
      comment: 'Олон улсын сургуулийн талаар сайн мэдээлэл авлаа.',
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ],
  'adv_003': [
    AdvisorReview(
      id: 'rev_006',
      studentName: 'Ганболд',
      rating: 5,
      comment:
          'Эмч багш маш сайхан ярьж, анагаах ухааны талаар урам зориг өглөө!',
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    AdvisorReview(
      id: 'rev_007',
      studentName: 'Сарнай',
      rating: 5,
      comment: 'Үнэхээр туслаж чадах мэргэжилтэн. Баярлалаа!',
      date: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ],
};

/// Mock чатын мессежүүд
List<ChatMessage> getMockMessages(String advisorId) {
  final now = DateTime.now();
  return [
    ChatMessage(
      id: 'msg_001',
      senderId: advisorId,
      text: 'Сайн байна уу? Танд яаж туслах вэ?',
      timestamp: now.subtract(const Duration(minutes: 25)),
      isMe: false,
    ),
    ChatMessage(
      id: 'msg_002',
      senderId: 'student_001',
      text: 'Сайн байна уу. IT мэргэжлийн талаар асуулт байна.',
      timestamp: now.subtract(const Duration(minutes: 24)),
      isMe: true,
    ),
    ChatMessage(
      id: 'msg_003',
      senderId: advisorId,
      text: 'Тийм ээ, асуугаарай. Миний мэргэжил бол IT талбар юм.',
      timestamp: now.subtract(const Duration(minutes: 23)),
      isMe: false,
    ),
    ChatMessage(
      id: 'msg_004',
      senderId: 'student_001',
      text: 'Компьютерийн ухаан болон Програм хангамж аль нь илүү сайн вэ?',
      timestamp: now.subtract(const Duration(minutes: 22)),
      isMe: true,
    ),
    ChatMessage(
      id: 'msg_005',
      senderId: advisorId,
      text:
          'Хоёулаа сайн сонголт. Компьютерийн ухаан илүү өргөн хүрээтэй - алгоритм, AI, датаны шинжлэх ухаан гэх мэт. Програм хангамж илүү практик чиглэлтэй - апп хөгжүүлэх, вэб хийх гэх мэт.',
      timestamp: now.subtract(const Duration(minutes: 21)),
      isMe: false,
    ),
    ChatMessage(
      id: 'msg_006',
      senderId: 'student_001',
      text:
          'Би апп хөгжүүлэх сонирхолтой байна. Програм хангамж сонгох нь дээр үү?',
      timestamp: now.subtract(const Duration(minutes: 19)),
      isMe: true,
    ),
    ChatMessage(
      id: 'msg_007',
      senderId: advisorId,
      text:
          'Тийм ээ, таны хувьд Програм хангамжийн инженерчлэл илүү тохиромжтой байж магадгүй. Гэхдээ аль алийг нь судалж үзээрэй. МУИС-д хоёр хөтөлбөр байдаг.',
      timestamp: now.subtract(const Duration(minutes: 18)),
      isMe: false,
    ),
    ChatMessage(
      id: 'msg_008',
      senderId: 'student_001',
      text: 'Баярлалаа! Маш их тусалсан.',
      timestamp: now.subtract(const Duration(minutes: 17)),
      isMe: true,
    ),
  ];
}

/// Цаг үүсгэх helper
List<DateTime> _generateSlots(DateTime startDate, List<int> hours) {
  final slots = <DateTime>[];
  for (int day = 0; day < 14; day++) {
    final date = startDate.add(Duration(days: day));
    for (final hour in hours) {
      slots.add(DateTime(date.year, date.month, date.day, hour, 0));
    }
  }
  return slots;
}
