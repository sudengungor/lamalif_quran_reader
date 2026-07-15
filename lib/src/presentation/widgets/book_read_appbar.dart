import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/book_back_button.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/book_settings_action_icon.dart';

class BookReadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookReadAppBar({super.key});

  static const _titleScale = TextScaler.linear(0.95);
  static const _subtitleScale = TextScaler.linear(0.85);

  @override
  Widget build(BuildContext context) {
    final l10n = context.quranL10n;

    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        final iconColor = provider.getIconColor();
        final surahTitle = provider.getCurrentSurahTitle();
        final subtitle = provider.getAppBarSubtitle(l10n);

        return AppBar(
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: provider.getBackgroundColor(),
          actionsPadding: const EdgeInsets.only(right: 10),
          centerTitle: true,
          titleSpacing: 0,
          leading: const BookBackButton(),
          automaticallyImplyLeading: false,
          title: surahTitle.isEmpty
              ? null
              : InkWell(
                  onTap: () {
                    context.bookReadEvent(BookReadEvents.fihristOpen);
                    Scaffold.of(context).openDrawer();
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                surahTitle,
                                textScaler: _titleScale,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: iconColor),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: iconColor.withValues(alpha: 0.6),
                            ),
                          ],
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 1),
                          Text(
                            subtitle,
                            textScaler: _subtitleScale,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: iconColor.withValues(alpha: 0.55),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
          actionsIconTheme: IconThemeData(color: iconColor),
          iconTheme: IconThemeData(color: iconColor),
          actions: const [BookSettingsActionIcon()],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
