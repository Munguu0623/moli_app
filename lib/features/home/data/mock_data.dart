// lib/features/home/data/mock_data.dart
import 'package:flutter/material.dart';
import '../../../core/widgets/atoms/app_chip.dart';
import '../domain/entities/career.dart';
import '../domain/entities/university.dart';
import '../domain/entities/advisor.dart';
import '../domain/entities/article.dart';
import '../domain/entities/course_bundle.dart';
import '../domain/entities/lesson.dart';
import '../domain/entities/trending_tag.dart';

/// Mock мэргэжлийн жагсаалт
final mockCareers = [
  const Career(
    id: '1',
    title: 'Программ хангамж хөгжүүлэгч',
    summary: 'Веб болон mobile app-ууд бүтээх, систем дизайн хийх',
    icon: Icons.computer,
    salary: '3-8 сая₮',
    outlook: '📈',
  ),
  const Career(
    id: '2',
    title: 'Өгөгдлийн шинжээч',
    summary: 'Big data-г шинжилж, бизнест ач холбогдолтой insights өгөх',
    icon: Icons.analytics,
    salary: '2.5-6 сая₮',
    outlook: '📈',
  ),
  const Career(
    id: '3',
    title: 'Эмч мэс заслын',
    summary: 'Хүний эрүүл мэндийг хамгаалж, мэс засал хийх',
    icon: Icons.medical_services,
    salary: '4-12 сая₮',
    outlook: '⚖️',
  ),
  const Career(
    id: '4',
    title: 'Санхүүгийн зөвлөх',
    summary: 'Хөрөнгө оруулалт, татварын зөвлөгөө өгөх',
    icon: Icons.account_balance,
    salary: '2-5 сая₮',
    outlook: '📈',
  ),
  const Career(
    id: '5',
    title: 'UI/UX дизайнер',
    summary: 'Хэрэглэгчдэд ээлтэй интерфейс, туршлага бүтээх',
    icon: Icons.design_services,
    salary: '1.5-4 сая₮',
    outlook: '📈',
  ),
  const Career(
    id: '6',
    title: 'Барилгын инженер',
    summary: 'Барилга байгууламжийн зураг төсөл боловсруулах',
    icon: Icons.construction,
    salary: '2-6 сая₮',
    outlook: '⚖️',
  ),
];

/// Mock их сургуулийн жагсаалт
final mockUniversities = [
  const University(
    id: '1',
    name: 'МУИС',
    logoUrl:
        'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=200&h=200&fit=crop',
    location: 'Улаанбаатар',
    tuition: '2.5-4 сая₮',
    programs: 120,
  ),
  const University(
    id: '2',
    name: 'ШУТИС',
    logoUrl:
        'https://images.unsplash.com/photo-1562774053-701939374585?w=200&h=200&fit=crop',
    location: 'Улаанбаатар',
    tuition: '2-3.5 сая₮',
    programs: 85,
  ),
  const University(
    id: '3',
    name: 'Анагаахын ШУТИС',
    logoUrl:
        'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=200&h=200&fit=crop',
    location: 'Улаанбаатар',
    tuition: '5-8 сая₮',
    programs: 45,
  ),
  const University(
    id: '4',
    name: 'Хууль Эрх Зүйн СШУИС',
    logoUrl:
        'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=200&h=200&fit=crop',
    location: 'Улаанбаатар',
    tuition: '3-5 сая₮',
    programs: 32,
  ),
  const University(
    id: '5',
    name: 'Соёл Урлагийн ИС',
    logoUrl:
        'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=200&h=200&fit=crop',
    location: 'Улаанбаатар',
    tuition: '1.5-3 сая₮',
    programs: 28,
  ),
  const University(
    id: '6',
    name: 'Хөдөө Аж Ахуйн ИС',
    logoUrl:
        'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=200&h=200&fit=crop',
    location: 'Дархан',
    tuition: '2-3 сая₮',
    programs: 55,
  ),
];

/// Mock зөвлөхийн жагсаалт
final mockAdvisors = [
  const Advisor(
    id: '1',
    name: 'Баярсайхан',
    title: 'IT чиглэлийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=33',
    rating: 4.9,
    price: '15,000₮',
  ),
  const Advisor(
    id: '2',
    name: 'Энхтуяа',
    title: 'Эрүүл мэндийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=45',
    rating: 4.8,
    price: '20,000₮',
  ),
  const Advisor(
    id: '3',
    name: 'Болдбаатар',
    title: 'Бизнесийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=12',
    rating: 4.7,
    price: '18,000₮',
  ),
  const Advisor(
    id: '4',
    name: 'Номин',
    title: 'Дизайн & Урлагийн зөвлөх',
    imageUrl: 'https://i.pravatar.cc/150?img=47',
    rating: 4.9,
    price: '12,000₮',
  ),
];

/// Mock хичээлийн багцууд (Course Bundles)
final mockCourseBundles = [
  CourseBundle(
    id: '1',
    title: 'Мэргэжил сонгох бүрэн гарын авлага',
    description: 'Мэргэжлээ зөв сонгож, карер төлөвлөлт хийх',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=225&fit=crop',
    totalDuration: '1 цаг 25 мин',
    totalLessons: 6,
    lessons: const [
      Lesson(
        id: '1-1',
        title: 'Мэргэжил гэж юу вэ?',
        duration: '8:30',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 1,
      ),
      Lesson(
        id: '1-2',
        title: 'Өөрийнхөө сонирхол, авъяасыг тодорхойлох',
        duration: '15:20',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 2,
      ),
      Lesson(
        id: '1-3',
        title: 'Боломжит мэргэжлүүдийг судлах арга',
        duration: '12:45',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 3,
      ),
      Lesson(
        id: '1-4',
        title: 'Зах зээлийн эрэлт хэрэгцээг ойлгох',
        duration: '18:15',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 4,
      ),
      Lesson(
        id: '1-5',
        title: 'Мэргэжилтнүүдтэй ярилцлага хийх',
        duration: '14:50',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 5,
      ),
      Lesson(
        id: '1-6',
        title: 'Эцсийн шийдвэр гаргах',
        duration: '15:40',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 6,
      ),
    ],
  ),
  CourseBundle(
    id: '2',
    title: 'IT карер эхлүүлэх',
    description: 'Программист болох бүх мэдлэг, зөвлөгөө',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400&h=225&fit=crop',
    totalDuration: '2 цаг 10 мин',
    totalLessons: 8,
    lessons: const [
      Lesson(
        id: '2-1',
        title: 'IT салбарын танилцуулга',
        duration: '10:20',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 1,
      ),
      Lesson(
        id: '2-2',
        title: 'Программ хангамжийн хөгжүүлэгч гэж хэн бэ?',
        duration: '12:30',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 2,
      ),
      Lesson(
        id: '2-3',
        title: 'Анхны программчлалын хэл сонгох',
        duration: '18:45',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 3,
      ),
      Lesson(
        id: '2-4',
        title: 'Портфолио бүтээх',
        duration: '22:15',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 4,
      ),
      Lesson(
        id: '2-5',
        title: 'GitHub ашиглах заавар',
        duration: '16:40',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 5,
      ),
      Lesson(
        id: '2-6',
        title: 'Анхны ажилдаа орох',
        duration: '19:30',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 6,
      ),
      Lesson(
        id: '2-7',
        title: 'Ярилцлагад бэлтгэх',
        duration: '20:50',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 7,
      ),
      Lesson(
        id: '2-8',
        title: 'Карерын хөгжил',
        duration: '9:30',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 8,
      ),
    ],
  ),
  CourseBundle(
    id: '3',
    title: 'Их сургуульд орох бэлтгэл',
    description: 'ЭЕШ-ээс элсэлт хүртэлх бүх зөвлөмж',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400&h=225&fit=crop',
    totalDuration: '1 цаг 45 мин',
    totalLessons: 7,
    lessons: const [
      Lesson(
        id: '3-1',
        title: 'Их сургуулийн систем танилцуулга',
        duration: '11:20',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 1,
      ),
      Lesson(
        id: '3-2',
        title: 'ЭЕШ-д бэлтгэх стратеги',
        duration: '18:40',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 2,
      ),
      Lesson(
        id: '3-3',
        title: 'Их сургууль сонгох аргачлал',
        duration: '16:25',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 3,
      ),
      Lesson(
        id: '3-4',
        title: 'Элсэлтийн материал бэлтгэх',
        duration: '14:50',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 4,
      ),
      Lesson(
        id: '3-5',
        title: 'Тэтгэлэг хөтөлбөрүүд',
        duration: '13:35',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 5,
      ),
      Lesson(
        id: '3-6',
        title: 'Оюутны амьдрал',
        duration: '12:20',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 6,
      ),
      Lesson(
        id: '3-7',
        title: 'Амжилттай элсэх 10 зөвлөмж',
        duration: '18:15',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 7,
      ),
    ],
  ),
  CourseBundle(
    id: '4',
    title: 'Карер төлөвлөлтийн мастер класс',
    description: 'Урт хугацааны карер төлөвлөлт хийх аргачлал',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400&h=225&fit=crop',
    totalDuration: '1 цаг 30 мин',
    totalLessons: 5,
    lessons: const [
      Lesson(
        id: '4-1',
        title: 'Карер гэж юу вэ?',
        duration: '10:15',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 1,
      ),
      Lesson(
        id: '4-2',
        title: '5 жилийн төлөвлөгөө гаргах',
        duration: '22:40',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 2,
      ),
      Lesson(
        id: '4-3',
        title: 'Чадвар хөгжүүлэх стратеги',
        duration: '18:30',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 3,
      ),
      Lesson(
        id: '4-4',
        title: 'Networking буюу хүний сүлжээ бий болгох',
        duration: '16:45',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 4,
      ),
      Lesson(
        id: '4-5',
        title: 'Төлөвлөгөөгөө хэрэгжүүлэх практик арга',
        duration: '21:50',
        youtubeUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        order: 5,
      ),
    ],
  ),
];

/// Mock trending tags - эрэлт хэрэгцээтэй тэмдэглэгээтэй
const mockTrendingTags = [
  TrendingTag(
    label: '#IT',
    demandLevel: ChipDemandLevel.hot,
    demandText: '+45% эрэлт',
  ),
  TrendingTag(
    label: '#Бизнес',
    demandLevel: ChipDemandLevel.trending,
    demandText: '2.5K оюутан',
  ),
  TrendingTag(
    label: '#Анагаах',
    demandLevel: ChipDemandLevel.hot,
    demandText: '+38% цалин',
  ),
  TrendingTag(
    label: '#Инженер',
    demandLevel: ChipDemandLevel.stable,
    demandText: '⭐ Тогтвортой',
  ),
  TrendingTag(
    label: '#Дизайн',
    demandLevel: ChipDemandLevel.trending,
    demandText: '+25% ажлын байр',
  ),
  TrendingTag(
    label: '#Хууль',
    demandLevel: ChipDemandLevel.stable,
    demandText: '1.8K оюутан',
  ),
];

/// Mock нийтлэл
final mockArticles = [
  Article(
    id: '1',
    title: '2025 онд эрэлттэй мэргэжлүүд',
    subtitle:
        'AI болон технологийн хөгжил мэргэжлийн зах зээлд хэрхэн нөлөөлж байна вэ',
    imageUrl:
        'https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?w=400&h=300&fit=crop',
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Article(
    id: '2',
    title: 'Их сургуульд орохын өмнө мэдэх ёстой зүйлс',
    subtitle:
        'Сурагчдын хамгийн их гаргадаг 10 алдаа болон тэдгээрээс хэрхэн зайлсхийх вэ',
    imageUrl:
        'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400&h=300&fit=crop',
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Article(
    id: '3',
    title: 'Тэтгэлэг хөтөлбөрүүд 2025',
    subtitle: 'Монгол оюутнуудад зориулсан олон улсын тэтгэлгийн боломжууд',
    imageUrl:
        'https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=400&h=300&fit=crop',
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
];
