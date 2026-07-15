import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';

/// Sayfa numarası girişi için diyalog açar.
/// Geçerli bir sayfaya gidildiyse `true` döner.
Future<bool> showGoToPageDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => const _GoToPageDialog(),
  );
  return result ?? false;
}

class _GoToPageDialog extends StatefulWidget {
  const _GoToPageDialog();

  @override
  State<_GoToPageDialog> createState() => _GoToPageDialogState();
}

class _GoToPageDialogState extends State<_GoToPageDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final l10n = context.quranL10n;
    final provider = context.read<BookReadProvider>();
    final raw = _controller.text.trim();

    if (raw.isEmpty) {
      setState(() => _errorText = l10n.bookEnterNumber);
      return;
    }

    final page = int.tryParse(raw);
    if (page == null) {
      setState(() => _errorText = l10n.bookEnterNumber);
      return;
    }

    final minPage = provider.minPhysicalPage;
    final maxPage = provider.maxPhysicalPage;
    if (page < minPage || page > maxPage) {
      setState(() => _errorText = '$minPage – $maxPage');
      return;
    }

    provider.goToPhysicalPage(page);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.quranL10n;
    final provider = context.watch<BookReadProvider>();
    final background = provider.getBackgroundColor();
    final textColor = provider.getTextColor();
    final minPage = provider.minPhysicalPage;
    final maxPage = provider.maxPhysicalPage;

    return AlertDialog(
      backgroundColor: background,
      title: Text(
        l10n.bookGoPage,
        style: TextStyle(color: textColor),
      ),
      content: TextField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.go,
        autofocus: true,
        style: TextStyle(color: textColor),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          hintText: l10n.bookEnterNumber,
          hintStyle: TextStyle(color: textColor.withValues(alpha: 0.45)),
          helperText: '$minPage – $maxPage',
          helperStyle: TextStyle(color: textColor.withValues(alpha: 0.55)),
          errorText: _errorText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor.withValues(alpha: 0.3)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
        ),
        onChanged: (_) {
          if (_errorText != null) {
            setState(() => _errorText = null);
          }
        },
        onSubmitted: (_) => _onSubmit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            l10n.bookCancel,
            style: TextStyle(color: textColor.withValues(alpha: 0.7)),
          ),
        ),
        TextButton(
          onPressed: _onSubmit,
          child: Text(
            l10n.bookGo,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
