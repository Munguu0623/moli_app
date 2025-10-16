// lib/features/tests/data/mock_questions.dart
import '../domain/entities/test_question.dart';

/// RIASEC тестийн 30 асуулт (Mock data)
/// R = Realistic, I = Investigative, A = Artistic, S = Social, E = Enterprising, C = Conventional
final List<TestQuestion> mockTestQuestions = [
  // Realistic (R) - 5 асуулт
  const TestQuestion(
    id: 'q1',
    number: 1,
    text: 'Би техник хэрэгсэл, машин механизмтай ажиллах дуртай.',
    category: 'R',
  ),
  const TestQuestion(
    id: 'q2',
    number: 2,
    text: 'Би гараараа юм хийх, засварлах дуртай.',
    category: 'R',
  ),
  const TestQuestion(
    id: 'q3',
    number: 3,
    text: 'Би гадна ажиллах, биеийн хөдөлгөөнтэй ажил хийх дуртай.',
    category: 'R',
  ),
  const TestQuestion(
    id: 'q4',
    number: 4,
    text: 'Би машин жолоодох, тээврийн хэрэгсэл удирдах сонирхолтой.',
    category: 'R',
  ),
  const TestQuestion(
    id: 'q5',
    number: 5,
    text: 'Би барилга, угсралтын ажил хийх дуртай.',
    category: 'R',
  ),

  // Investigative (I) - 5 асуулт
  const TestQuestion(
    id: 'q6',
    number: 6,
    text: 'Би судалгаа хийх, шинэ зүйл олж мэдэх дуртай.',
    category: 'I',
  ),
  const TestQuestion(
    id: 'q7',
    number: 7,
    text: 'Би математик, шинжлэх ухааны асуудал шийдэх дуртай.',
    category: 'I',
  ),
  const TestQuestion(
    id: 'q8',
    number: 8,
    text: 'Би бодитой асуудлыг шинжилгээ судалгаагаар шийдэх дуртай.',
    category: 'I',
  ),
  const TestQuestion(
    id: 'q9',
    number: 9,
    text: 'Би эмийн найрлага, химийн урвал судлах сонирхолтой.',
    category: 'I',
  ),
  const TestQuestion(
    id: 'q10',
    number: 10,
    text: 'Би өгөгдөл шинжлэх, дүгнэлт гаргах дуртай.',
    category: 'I',
  ),

  // Artistic (A) - 5 асуулт
  const TestQuestion(
    id: 'q11',
    number: 11,
    text: 'Би бүтээлч санаа гаргах, дизайн хийх дуртай.',
    category: 'A',
  ),
  const TestQuestion(
    id: 'q12',
    number: 12,
    text: 'Би уран зургийн ажил хийх, зураг зурах дуртай.',
    category: 'A',
  ),
  const TestQuestion(
    id: 'q13',
    number: 13,
    text: 'Би хөгжим тоглох, дуу хөөрөг бүтээх сонирхолтой.',
    category: 'A',
  ),
  const TestQuestion(
    id: 'q14',
    number: 14,
    text: 'Би найруулагч, зохиолч болох дуртай.',
    category: 'A',
  ),
  const TestQuestion(
    id: 'q15',
    number: 15,
    text: 'Би гоо зүйн ажил хийх, загвар зохион бүтээх дуртай.',
    category: 'A',
  ),

  // Social (S) - 5 асуулт
  const TestQuestion(
    id: 'q16',
    number: 16,
    text: 'Би хүмүүст тусалж, зааж зөвлөх дуртай.',
    category: 'S',
  ),
  const TestQuestion(
    id: 'q17',
    number: 17,
    text: 'Би бусадтай харилцах, баг болон ажиллах дуртай.',
    category: 'S',
  ),
  const TestQuestion(
    id: 'q18',
    number: 18,
    text: 'Би хүүхэд залуусыг өсгөн хүмүүжүүлэх дуртай.',
    category: 'S',
  ),
  const TestQuestion(
    id: 'q19',
    number: 19,
    text: 'Би хүмүүсийн асуудал шийдэхэд туслах сонирхолтой.',
    category: 'S',
  ),
  const TestQuestion(
    id: 'q20',
    number: 20,
    text: 'Би эмнэлгийн тусламж үзүүлэх, эмчлэх дуртай.',
    category: 'S',
  ),

  // Enterprising (E) - 5 асуулт
  const TestQuestion(
    id: 'q21',
    number: 21,
    text: 'Би хүмүүсийг удирдаж, манлайлах дуртай.',
    category: 'E',
  ),
  const TestQuestion(
    id: 'q22',
    number: 22,
    text: 'Би бизнес эрхлэх, худалдаа хийх сонирхолтой.',
    category: 'E',
  ),
  const TestQuestion(
    id: 'q23',
    number: 23,
    text: 'Би хүмүүсийг итгүүлэх, санал болгох дуртай.',
    category: 'E',
  ),
  const TestQuestion(
    id: 'q24',
    number: 24,
    text: 'Би төсөл хөтөлбөр удирдах, санхүүжүүлэх дуртай.',
    category: 'E',
  ),
  const TestQuestion(
    id: 'q25',
    number: 25,
    text: 'Би нийтийн өмнө ярих, танилцуулга хийх дуртай.',
    category: 'E',
  ),

  // Conventional (C) - 5 асуулт
  const TestQuestion(
    id: 'q26',
    number: 26,
    text: 'Би баримт бичиг боловсруулах, эмх цэгц сахих дуртай.',
    category: 'C',
  ),
  const TestQuestion(
    id: 'q27',
    number: 27,
    text: 'Би мөнгөний тооцоо хийх, нягтлан бодох дуртай.',
    category: 'C',
  ),
  const TestQuestion(
    id: 'q28',
    number: 28,
    text: 'Би өгөгдөл оруулах, баазтай ажиллах сонирхолтой.',
    category: 'C',
  ),
  const TestQuestion(
    id: 'q29',
    number: 29,
    text: 'Би журам дүрэм дагаж, дэг сахих дуртай.',
    category: 'C',
  ),
  const TestQuestion(
    id: 'q30',
    number: 30,
    text: 'Би захиргааны ажил хийх, албан хэрэг бүрдүүлэх дуртай.',
    category: 'C',
  ),
];
