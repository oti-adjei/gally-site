import 'dart:ui' show FontFeature;
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

// Editable custom widget starters for iOS and Android.
// No Material or Cupertino widget styling is required. Integrate and compile
// against your application's pinned Flutter SDK before shipping.
class GallyPalette {
  final Color canvas, surface, ink, muted, action, onAction, mint, onMint, line;
  const GallyPalette({required this.canvas, required this.surface,
    required this.ink, required this.muted, required this.action,
    required this.onAction, required this.mint, required this.onMint,
    required this.line});
  static const light = GallyPalette(
    canvas: Color(0xFFFFFFFF), surface: Color(0xFFF1F5F2),
    ink: Color(0xFF182E27), muted: Color(0xFF5E6E66),
    action: Color(0xFF184D3D), onAction: Color(0xFFFFFFFF),
    mint: Color(0xFFDFF3E9), onMint: Color(0xFF143C30),
    line: Color(0xFFDDE5DF));
  static const dark = GallyPalette(
    canvas: Color(0xFF14221C), surface: Color(0xFF20332A),
    ink: Color(0xFFEBF1EC), muted: Color(0xFFB8C6BC),
    action: Color(0xFFACD5BD), onAction: Color(0xFF10382B),
    mint: Color(0xFF244F3D), onMint: Color(0xFFDFF3E9),
    line: Color(0xFF3C4C41));
}

class GallyPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final GallyPalette palette;
  const GallyPrimaryButton({super.key, required this.label,
    required this.onPressed, required this.palette});
  @override State<GallyPrimaryButton> createState() => _GallyPrimaryButtonState();
}
class _GallyPrimaryButtonState extends State<GallyPrimaryButton> {
  bool focused = false;
  @override Widget build(BuildContext context) {
    final p = widget.palette;
    final enabled = widget.onPressed != null;
    return Semantics(
      button: true, enabled: enabled, label: widget.label,
      excludeSemantics: true,
      child: FocusableActionDetector(
        enabled: enabled,
        onShowFocusHighlight: (value) => setState(() => focused = value),
        mouseCursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {
            widget.onPressed?.call(); return null;
          }),
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          behavior: HitTestBehavior.opaque,
          child: Container(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: enabled ? p.action : p.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: focused ? p.ink :
                (enabled ? p.action : p.line), width: focused ? 3 : 1),
            ),
            alignment: Alignment.center,
            child: Text(widget.label, textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Fusion Neue', fontSize: 16,
                height: 1.5, fontWeight: FontWeight.w600,
                color: enabled ? p.onAction : p.muted)),
          ),
        ),
      ),
    );
  }
}

class GallyAmount extends StatelessWidget {
  final int minorUnits;
  final String currency;
  final String semanticsLabel; // Localised, e.g. “forty-five Ghanaian cedis”.
  final Color color;
  const GallyAmount({super.key, required this.minorUnits,
    required this.currency, required this.semanticsLabel, required this.color});
  @override Widget build(BuildContext context) {
    final magnitude = minorUnits.abs();
    // Keep integer arithmetic here. Add the app's locale grouping formatter.
    final whole = magnitude ~/ 100;
    final cents = (magnitude % 100).toString().padLeft(2, '0');
    final display = '${minorUnits < 0 ? '−' : ''}$currency $whole.$cents';
    return Semantics(label: semanticsLabel, excludeSemantics: true,
      child: Text(display,
        style: TextStyle(fontFamily: 'Gally Numeric', fontSize: 32,
          fontFeatures: const [FontFeature.tabularFigures()],
          height: 1.2, color: color)));
  }
}

class GallySurface extends StatelessWidget {
  final Widget child;
  final GallyPalette palette;
  const GallySurface({super.key, required this.child, required this.palette});
  @override Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: palette.surface,
      borderRadius: BorderRadius.circular(16)),
    child: Padding(padding: const EdgeInsets.all(24), child: child));
}

// App host supplies Directionality, DefaultTextStyle, MediaQuery, localisation,
// navigation, and SafeArea. These starters do not prescribe a MaterialApp.
// Use device text scaling without clamping accessibility sizes. Amount layouts
// must reflow before they overflow; never abbreviate or silently clip money.
