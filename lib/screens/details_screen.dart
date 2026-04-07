import 'package:flutter/material.dart';
import 'studies_screen.dart';

class DetailsScreen extends StatelessWidget {
  final StudySession sessao;

  const DetailsScreen({super.key, required this.sessao});

  @override
  Widget build(BuildContext context) {
    final dia = sessao.data.day.toString().padLeft(2, '0');
    final mes = sessao.data.month.toString().padLeft(2, '0');
    final ano = sessao.data.year;
    final hora = sessao.data.hour.toString().padLeft(2, '0');
    final min = sessao.data.minute.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Detalhes da Sessão',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFFF0000).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.code, color: Color(0xFFFF0000), size: 44),
            ),

            const SizedBox(height: 24),

            Text(
              sessao.tecnologia,
              style: const TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              '$dia/$mes/$ano às $hora:$min',
              style: const TextStyle(color: Colors.black38, fontSize: 14),
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'DURAÇÃO DA SESSÃO',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${sessao.horas % 1 == 0 ? sessao.horas.toInt() : sessao.horas.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const Text(
                    'horas',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.black38,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Sessão de estudo em ${sessao.tecnologia} registrada com sucesso no DevTracker.',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0000),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Voltar ao Histórico',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
