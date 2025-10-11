// lib/features/home/data/mock_data.dart
import 'package:flutter/material.dart';
import '../domain/entities/career.dart';
import '../domain/entities/university.dart';
import '../domain/entities/advisor.dart';
import '../domain/entities/article.dart';

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

/// Mock trending tags
const mockTrendingTags = [
  '#IT',
  '#Бизнес',
  '#Анагаах',
  '#Инженер',
  '#Дизайн',
  '#Хууль',
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
