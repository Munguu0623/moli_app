// lib/ui_kit.dart
import 'package:flutter/material.dart';

/// =========================
/// TOKENS & THEME (Minimal Light)
/// =========================

class AppTokens {
  // Colors
  static const primary = Color(0xFF2D5BFF);
  static const secondaryBg = Color(0xFFF2F6FF);
  static const accent = Color(0xFFFFD447);
  static const textDark = Color(0xFF1E1E1E);
  static const textMuted = Color(0xFF6B7280);
  static const borderLight = Color(0xFFE5E7EB);

  // Spacing
  static const base = 8.0;

  // Radius
  static const r12 = 12.0;
  static const r16 = 16.0;

  // Shadows
  static const s1 = [
    BoxShadow(
      color: Color(0x0A000000), // rgba(0,0,0,0.04)
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
  static const s2 = [
    BoxShadow(
      color: Color(0x10000000), // rgba(0,0,0,0.06)
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];
  static const s3 = [
    BoxShadow(
      color: Color(0x14000000), // rgba(0,0,0,0.08)
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
}

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppTokens.primary,
    primary: AppTokens.primary,
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
  );

  const textTheme = TextTheme(
    // Typography scale
    headlineSmall: TextStyle(
      // H1 ~ 28 Bold
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 36 / 28,
      color: AppTokens.textDark,
    ),
    titleLarge: TextStyle(
      // H2 ~ 22 SemiBold
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 30 / 22,
      color: AppTokens.textDark,
    ),
    bodyLarge: TextStyle(
      // Body ~ 16 Regular
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
      color: AppTokens.textDark,
    ),
    bodySmall: TextStyle(
      // Caption ~ 12 Medium
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 18 / 12,
      color: AppTokens.textMuted,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppTokens.textDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: AppTokens.textMuted),
      labelStyle: const TextStyle(color: AppTokens.textMuted, fontSize: 12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
        borderSide: const BorderSide(color: AppTokens.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
        borderSide: const BorderSide(color: AppTokens.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
        borderSide: const BorderSide(color: AppTokens.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppTokens.borderLight,
      thickness: 1,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppTokens.primary,
      labelColor: AppTokens.primary,
      unselectedLabelColor: AppTokens.textMuted,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppTokens.primary,
      unselectedItemColor: AppTokens.textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}

/// =========================
/// BUTTONS
/// =========================

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTokens.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.r12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        elevation: 0,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTokens.textDark,
        side: const BorderSide(color: AppTokens.borderLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.r12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class TonalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  const TonalButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFE8EEFF);
    final btn = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: AppTokens.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.r12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class TextLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const TextLinkButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppTokens.primary,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.r12),
        ),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class IconFilledButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const IconFilledButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTokens.primary,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.r12),
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

class IconOutlineButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const IconOutlineButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppTokens.borderLight),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.r12),
          ),
        ),
        child: Icon(icon, color: AppTokens.primary, size: 24),
      ),
    );
  }
}

/// =========================
/// INPUTS & CONTROLS
/// =========================

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? errorText;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint, errorText: errorText),
        ),
      ],
    );
  }
}

class LabeledSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const LabeledSwitch({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(value: value, onChanged: onChanged),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class LabeledRadio<T> extends StatelessWidget {
  final String label;
  final T groupValue;
  final T value;
  final ValueChanged<T?>? onChanged;

  const LabeledRadio({
    super.key,
    required this.label,
    required this.groupValue,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(value: value, groupValue: groupValue, onChanged: onChanged),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

/// =========================
/// CONTENT CARDS
/// =========================

class ContentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final VoidCallback? onPressed;

  const ContentCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTokens.r16),
        border: Border.all(color: AppTokens.borderLight),
        boxShadow: AppTokens.s3,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          leading ??
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTokens.secondaryBg,
                  borderRadius: BorderRadius.circular(AppTokens.r12),
                ),
              ),
          const SizedBox(width: 16),
          Expanded(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyLarge!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTokens.textMuted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          SecondaryButton(
            label: "Дэлгэрэнгүй",
            expanded: false,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

/// =========================
/// CHIPS & BADGES
/// =========================

class FilterChipPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const FilterChipPill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTokens.primary : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppTokens.primary : AppTokens.borderLight,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppTokens.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class BadgeSmall extends StatelessWidget {
  final String text;
  final Color color;

  const BadgeSmall({
    super.key,
    required this.text,
    this.color = AppTokens.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppTokens.textDark,
        ),
      ),
    );
  }
}

/// =========================
/// LISTS & AVATARS
/// =========================

class OneLineTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const OneLineTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
      ),
    );
  }
}

class TwoLineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const TwoLineTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppTokens.textMuted),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.r12),
      ),
    );
  }
}

/// =========================
/// FEEDBACK (Snackbar, Dialog, Bottom Sheet)
/// =========================

void showAppSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xE61F2937), // 90%
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}

Future<void> showAppDialog(
  BuildContext context, {
  required String title,
  required String body,
}) async {
  await showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.r16),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Text(body, style: const TextStyle(fontSize: 14)),
        actions: [
          TextLinkButton(
            label: 'Болих',
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          PrimaryButton(
            label: 'Зөвшөөрөх',
            expanded: false,
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      );
    },
  );
}

Future<void> showAppBottomSheet(BuildContext context, Widget child) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppTokens.r16)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(ctx).padding.bottom + 16,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTokens.borderLight,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      );
    },
  );
}

/// =========================
/// SKELETON / LOADING
/// =========================

class SkeletonBlock extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const SkeletonBlock({
    super.key,
    required this.width,
    required this.height,
    this.radius = AppTokens.r12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTokens.secondaryBg,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// =========================
/// NAVIGATION (AppBar, BottomNav, Tabs)
/// =========================

class BottomNavScaffold extends StatefulWidget {
  const BottomNavScaffold({super.key});

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _HomePreview(),
      const _TestsPreview(),
      const _UnivPreview(),
      const _AdvisorPreview(),
      const _ProfilePreview(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Edu Mentor')),
      body: pages[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (v) => setState(() => idx = v),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Univ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            label: 'Advis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// =========================
/// DEMO PAGES
/// =========================

class _HomePreview extends StatelessWidget {
  const _HomePreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('H1 — Нүүр', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text(
          'Caption — танилцуулга',
          style: TextStyle(
            color: AppTokens.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 16),
        const PrimaryButton(label: 'Үргэлжлүүлэх'),
        const SizedBox(height: 8),
        const SecondaryButton(label: 'Дараа нь'),
        const SizedBox(height: 8),
        const TonalButton(label: 'Сонсох хөтөлбөр'),
        const SizedBox(height: 8),
        const TextLinkButton(label: 'Дэлгэрэнгүй →'),

        const SizedBox(height: 24),
        const ContentCard(
          title: 'Тест — MBTI',
          subtitle:
              '16 асуулт • 5–7 минут • Таныхтай тохирох мэргэжлийг санал болгоно.',
        ),
        const SizedBox(height: 12),
        const ContentCard(
          title: 'Их сургууль',
          subtitle: 'MUST • CS • 3.2 сая/сем • Хөтөлбөр, төлөвлөгөө, байршил',
        ),

        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            FilterChipPill(label: 'IT', selected: true),
            FilterChipPill(label: 'Эрүүл мэнд'),
            FilterChipPill(label: 'Инженер'),
            BadgeSmall(text: 'NEW'),
          ],
        ),

        const SizedBox(height: 24),
        const OneLineTile(title: 'Тусламж ба асуултууд'),
        const TwoLineTile(
          title: 'Профайл',
          subtitle: 'Таны мэдээлэл • Тохиргоо',
        ),

        const SizedBox(height: 24),
        Row(
          children: const [
            SkeletonBlock(width: 72, height: 72),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBlock(width: 180, height: 16),
                  SizedBox(height: 8),
                  SkeletonBlock(width: 240, height: 14),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _TestsPreview extends StatefulWidget {
  const _TestsPreview();

  @override
  State<_TestsPreview> createState() => _TestsPreviewState();
}

class _TestsPreviewState extends State<_TestsPreview> {
  final _name = TextEditingController();
  bool agree = false;
  bool sw = true;
  String group = 'a';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Тест бүртгүүлэх', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        LabeledTextField(label: 'Нэр', hint: 'Бат-Эрдэнэ', controller: _name),
        const SizedBox(height: 12),
        const LabeledTextField(label: 'И-мэйл', hint: 'name@email.com'),
        const SizedBox(height: 12),
        const LabeledTextField(
          label: 'Утас',
          hint: 'Алдаа жишээ',
          errorText: 'Буруу формат',
        ),
        const SizedBox(height: 16),
        LabeledCheckbox(
          label: 'Үйлчилгээний нөхцлийг зөвшөөрөх',
          value: agree,
          onChanged: (v) => setState(() => agree = v ?? false),
        ),
        const SizedBox(height: 8),
        LabeledSwitch(
          label: 'Мэдэгдэл авах',
          value: sw,
          onChanged: (v) => setState(() => sw = v),
        ),
        const SizedBox(height: 8),
        LabeledRadio<String>(
          label: 'A хувилбар',
          groupValue: group,
          value: 'a',
          onChanged: (v) => setState(() => group = v ?? 'a'),
        ),
        LabeledRadio<String>(
          label: 'B хувилбар',
          groupValue: group,
          value: 'b',
          onChanged: (v) => setState(() => group = v ?? 'a'),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          label: 'Илгээх',
          onPressed: () => showAppSnackBar(context, 'Амжилттай илгээлээ'),
        ),
      ],
    );
  }
}

class _UnivPreview extends StatelessWidget {
  const _UnivPreview();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const SizedBox(height: 8),
          const TabBar(
            tabs: [Tab(text: 'Топ'), Tab(text: 'Хот'), Tab(text: 'Төлбөр')],
          ),
          const Divider(height: 1),
          Expanded(child: TabBarView(children: [_grid(), _grid(), _grid()])),
        ],
      ),
    );
  }

  static Widget _grid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
      itemCount: 6,
      itemBuilder: (_, i) {
        return ContentCard(
          title: 'Сургууль ${i + 1}',
          subtitle: 'CS • 3.2 сая/сем',
          onPressed: () {},
        );
      },
    );
  }
}

class _AdvisorPreview extends StatelessWidget {
  const _AdvisorPreview();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder:
          (_, i) => ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: AppTokens.secondaryBg,
              child: Text(
                'E$i',
                style: const TextStyle(color: AppTokens.textDark),
              ),
            ),
            title: Text(
              'Эксперт $i',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text(
              '30 мин • Онлайн, чат',
              style: TextStyle(color: AppTokens.textMuted),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTokens.r12),
            ),
          ),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: 10,
    );
  }
}

class _ProfilePreview extends StatelessWidget {
  const _ProfilePreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: AppTokens.secondaryBg,
              child: Icon(Icons.person, color: AppTokens.textDark),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'User Name',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'test@gmail.com',
                    style: TextStyle(color: AppTokens.textMuted),
                  ),
                ],
              ),
            ),
            BadgeSmall(text: 'PRO', color: AppTokens.accent),
          ],
        ),
        const SizedBox(height: 16),
        const OneLineTile(title: 'Тохиргоо'),
        const OneLineTile(title: 'Төлбөрийн мэдээлэл'),
        const OneLineTile(title: 'Тусламж'),
        const SizedBox(height: 16),
        SecondaryButton(label: 'Гарах', onPressed: () {}),
      ],
    );
  }
}

/// =========================
/// DEMO APP
/// =========================
