import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/domain/service/book_read_preferences.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/book_read_appbar.dart';
import 'package:quran_reader/src/presentation/widgets/book_read_body.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/enhanced_book_drawer.dart';

class BookReadView extends StatefulWidget {
  const BookReadView({super.key, this.onEvent});

  final BookReadEventCallback? onEvent;

  @override
  State<BookReadView> createState() => _BookReadViewState();
}

class _BookReadViewState extends State<BookReadView>
    with WidgetsBindingObserver {
  BookReadProvider? _provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = context.read<BookReadProvider>();
      // Meal yalnızca Türkçe'de var; diğer dillerde pref'i kapat.
      if (context.quranL10n.langCode != 'tr') {
        context.read<BookReadPreferences>().setMealEnabled(false);
      }
      provider.init();
      provider.reloadSavedPosition();
      context.bookReadEvent(BookReadEvents.viewOpen);
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = context.read<BookReadProvider>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _provider?.saveCurrentReadingPosition();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _provider?.saveCurrentReadingPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BookReadEventScope(
      onEvent: widget.onEvent,
      child: Consumer<BookReadProvider>(
        builder: (context, provider, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) async {
              if (didPop) return;
              await provider.saveCurrentReadingPosition();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: Scaffold(
              backgroundColor: provider.getBackgroundColor(),
              appBar: const BookReadAppBar(),
              drawer: const BookReadDrawer(),
              body: const SafeArea(bottom: false, child: BookReadBody()),
            ),
          );
        },
      ),
    );
  }
}
