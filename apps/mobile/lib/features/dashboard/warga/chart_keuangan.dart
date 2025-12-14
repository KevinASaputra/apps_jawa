import 'package:flutter/material.dart';

class ChartKeuangan extends StatefulWidget {
  final Map<String, Map<String, double>> data;

  const ChartKeuangan({super.key, required this.data});

  @override
  State<ChartKeuangan> createState() =>
      _ChartKeuanganState();
}

class _ChartKeuanganState extends State<ChartKeuangan> {
  String? _selectedBulan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Keuangan Bulanan",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LayoutBuilder(builder: (context, constraints) {
              return GestureDetector(
                onTapDown: (details) {
                  final pos = details.localPosition;
                  final barWidth = constraints.maxWidth / (widget.data.length * 3);
                  int index = (pos.dx / (barWidth * 3)).floor();
                  if (index >= 0 && index < widget.data.length) {
                    setState(() {
                      _selectedBulan =
                          widget.data.keys.toList()[index]; // pilih bulan
                    });
                  }
                },
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: _InteractiveChartPainter(
                          widget.data, _selectedBulan),
                    ),
                    if (_selectedBulan != null)
                      Positioned(
                        top: 0,
                        left: constraints.maxWidth *
                            (widget.data.keys.toList().indexOf(_selectedBulan!) /
                                widget.data.length),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "${_selectedBulan!}\nPemasukan: ${widget.data[_selectedBulan!]!['pemasukan']}\nPengeluaran: ${widget.data[_selectedBulan!]!['pengeluaran']}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _InteractiveChartPainter extends CustomPainter {
  final Map<String, Map<String, double>> data;
  final String? selectedBulan;

  _InteractiveChartPainter(this.data, this.selectedBulan);

  @override
  void paint(Canvas canvas, Size size) {
    final pemasukanPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final pengeluaranPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final barWidth = size.width / (data.length * 3);
    final maxValue = data.values
        .map((v) => [v['pemasukan'] ?? 0, v['pengeluaran'] ?? 0]
            .reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b);

    int index = 0;
    data.forEach((bulan, value) {
      final pemasukanHeight =
          ((value['pemasukan'] ?? 0) / maxValue) * (size.height - 40);
      final pengeluaranHeight =
          ((value['pengeluaran'] ?? 0) / maxValue) * (size.height - 40);

      final xPemasukan = barWidth + index * barWidth * 3;
      final xPengeluaran = xPemasukan + barWidth + 4;

      final yPemasukan = size.height - pemasukanHeight;
      final yPengeluaran = size.height - pengeluaranHeight;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(xPemasukan, yPemasukan, barWidth, pemasukanHeight),
            const Radius.circular(6)),
        pemasukanPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(xPengeluaran, yPengeluaran, barWidth, pengeluaranHeight),
            const Radius.circular(6)),
        pengeluaranPaint,
      );

      // optional: draw mini label
      if (selectedBulan == bulan) {
        textPainter.text = TextSpan(
          text: bulan,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        );
        textPainter.layout();
        textPainter.paint(
            canvas,
            Offset(xPemasukan + (barWidth + 4) / 2 - textPainter.width / 2,
                size.height - 18));
      }

      index++;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
