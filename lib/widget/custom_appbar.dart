import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
// Make sure WaveClipper is imported

class CustomWaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double titleTop;
  final double titleLeft;
  final double iconTop;
  final double iconLeft;
  final VoidCallback? onBack;
  final bool showBackButton;
  final bool showMenuButton;

  const CustomWaveAppBar({
    super.key,
    required this.title,
    this.titleTop = 50,
    this.titleLeft = 60,
    this.iconTop = 40,
    this.iconLeft = 10,
    this.onBack,
    this.showBackButton = false,
    this.showMenuButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 10.h,
              color: Colors.indigo.shade900,
            ),
          ),

          // Back button (if enabled)
          if (showBackButton)
            Positioned(
              top: iconTop,
              left: iconLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack ?? () => Navigator.of(context).pop(),
              ),
            ),

          // Menu button (if enabled)
          if (showMenuButton)
            Positioned(
              top: iconTop,
              left: iconLeft,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),

          // Title
          Positioned(
            top: titleTop,
            left: titleLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 29);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height - 40, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
     return false;
  }
}