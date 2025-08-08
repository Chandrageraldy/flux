import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class CornerFramePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double edgeLength;
  final double cornerRadius;

  CornerFramePainter({
    required this.color,
    this.strokeWidth = 4,
    this.edgeLength = 30,
    this.cornerRadius = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = Radius.circular(cornerRadius);

    // Top-left corner
    final topLeft = Path()
      ..moveTo(0, edgeLength)
      ..lineTo(0, cornerRadius)
      ..arcToPoint(
        Offset(cornerRadius, 0),
        radius: radius,
        clockwise: true,
      )
      ..lineTo(edgeLength, 0);
    canvas.drawPath(topLeft, paint);

    // Top-right corner
    final topRight = Path()
      ..moveTo(size.width - edgeLength, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..arcToPoint(
        Offset(size.width, cornerRadius),
        radius: radius,
        clockwise: true,
      )
      ..lineTo(size.width, edgeLength);
    canvas.drawPath(topRight, paint);

    // Bottom-right corner
    final bottomRight = Path()
      ..moveTo(size.width, size.height - edgeLength)
      ..lineTo(size.width, size.height - cornerRadius)
      ..arcToPoint(
        Offset(size.width - cornerRadius, size.height),
        radius: radius,
        clockwise: true,
      )
      ..lineTo(size.width - edgeLength, size.height);
    canvas.drawPath(bottomRight, paint);

    // Bottom-left corner
    final bottomLeft = Path()
      ..moveTo(edgeLength, size.height)
      ..lineTo(cornerRadius, size.height)
      ..arcToPoint(
        Offset(0, size.height - cornerRadius),
        radius: radius,
        clockwise: true,
      )
      ..lineTo(0, size.height - edgeLength);
    canvas.drawPath(bottomLeft, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
