import 'package:flutter/material.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:gifza/screens/library.dart';
import 'package:gifza/widgets/uploadAssetsModal.dart';
import 'package:provider/provider.dart';

class UploadNewCard extends StatefulWidget {
  final Function() onPressed;
  const UploadNewCard({super.key, required this.onPressed});

  @override
  State<UploadNewCard> createState() => _UploadNewCardState();
}

class _UploadNewCardState extends State<UploadNewCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return UploadAssetModal();
            });
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          scale: _hovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  scheme.tertiary,
                  scheme.tertiary.withOpacity(_hovered ? 0.9 : 0.85)
                ],
              ),
              color: scheme.tertiary,
              borderRadius: BorderRadius.circular(50),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: scheme.tertiary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ]
                  : [],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedScale(
                    scale: _hovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: const Icon(Icons.upload_file,
                          color: Colors.white, size: 32),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _hovered ? 18 : 16,
                      fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
                    ),
                    child: const Text('Upload an Image or GIF'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LibraryActionCard extends StatefulWidget {
  const LibraryActionCard({super.key});

  @override
  State<LibraryActionCard> createState() => _LibraryActionCardState();
}

class _LibraryActionCardState extends State<LibraryActionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final screenProvider = Provider.of<ScreenProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        screenProvider.routeToScreen(screen: AppScreen.library);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          scale: _hovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:
                  _hovered ? const Color(0xFF1A2744) : const Color(0xFF141f38),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedScale(
                    scale: _hovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: scheme.surface.withOpacity(0.4),
                      ),
                      child: const Icon(Icons.library_add,
                          color: Colors.white, size: 32),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _hovered ? 18 : 16,
                      fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
                    ),
                    child: const Text('Open Library'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RecentAssetsCard extends StatefulWidget {
  const RecentAssetsCard({super.key});

  @override
  State<RecentAssetsCard> createState() => _RecentAssetsCardState();
}

class _RecentAssetsCardState extends State<RecentAssetsCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {},
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          scale: _hovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:
                  _hovered ? const Color(0xFF1A2744) : const Color(0xFF141f38),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedScale(
                    scale: _hovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: scheme.surface.withOpacity(0.4),
                      ),
                      child: const Icon(Icons.history,
                          color: Colors.white, size: 32),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _hovered ? 18 : 16,
                      fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
                    ),
                    child: const Text('Recent Assets'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
