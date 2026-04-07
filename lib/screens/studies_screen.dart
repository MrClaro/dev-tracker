import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'details_screen.dart';

class StudySession {
  final String tecnologia;
  final double horas;
  final DateTime data;

  StudySession({
    required this.tecnologia,
    required this.horas,
    required this.data,
  });
}

class StudiesScreen extends StatefulWidget {
  const StudiesScreen({super.key});

  @override
  State<StudiesScreen> createState() => _StudiesScreenState();
}

class _StudiesScreenState extends State<StudiesScreen> {
  final _tecController = TextEditingController();
  final _horasController = TextEditingController();
  final List<StudySession> _sessoes = [];
  double _totalHoras = 0;
  String? _erro;

  @override
  void dispose() {
    _tecController.dispose();
    _horasController.dispose();
    super.dispose();
  }

  void _registrar() {
    final tec = _tecController.text.trim();
    final horasTexto = _horasController.text.trim();
    final horas = double.tryParse(horasTexto);

    if (tec.isEmpty || horasTexto.isEmpty || horas == null || horas <= 0) {
      setState(
        () => _erro =
            'Preencha os campos corretamente. Horas deve ser maior que zero.',
      );
      return;
    }

    setState(() {
      _erro = null;
      _sessoes.insert(
        0,
        StudySession(tecnologia: tec, horas: horas, data: DateTime.now()),
      );
      _totalHoras += horas;
      _tecController.clear();
      _horasController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Registro de Estudos',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Painel totalizador usando Card conforme solicitado
            Card(
              color: const Color(0xFFFF0000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Text(
                        _totalHoras % 1 == 0
                            ? _totalHoras.toInt().toString()
                            : _totalHoras.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const Text(
                        'horas estudadas',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _tecController,
              style: const TextStyle(color: Color(0xFF1A1A2E)),
              decoration: _inputDecoration(
                'Tecnologia / Linguagem',
                Icons.terminal,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _horasController,
              style: const TextStyle(color: Color(0xFF1A1A2E)),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: _inputDecoration(
                'Horas Estudadas',
                Icons.access_time,
              ),
            ),

            if (_erro != null) ...[
              const SizedBox(height: 8),
              Text(
                _erro!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ],

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _registrar,
                icon: const Icon(Icons.add_circle_outline),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0000),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                label: const Text(
                  'Registrar Sessão',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text(
                  'HISTÓRICO',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_sessoes.length}',
                    style: const TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _sessoes.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            color: Colors.black12,
                            size: 48,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Nenhuma sessão registrada ainda.',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _sessoes.length,
                      itemBuilder: (context, index) {
                        final sessao = _sessoes[index];
                        return _SessaoCard(
                          sessao: sessao,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(sessao: sessao),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black45),
      prefixIcon: Icon(icon, color: const Color(0xFFFF0000)),
      filled: true,
      fillColor: const Color(0xFFE8E8E8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF0000), width: 1.5),
      ),
    );
  }
}

class _SessaoCard extends StatelessWidget {
  final StudySession sessao;
  final VoidCallback onTap;

  const _SessaoCard({required this.sessao, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hora = sessao.data.hour.toString().padLeft(2, '0');
    final min = sessao.data.minute.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: const Color(0xFFE0E0E0),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.code,
                    color: Color(0xFFFF0000),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sessao.tecnologia,
                        style: const TextStyle(
                          color: Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Hoje às $hora:$min',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${sessao.horas % 1 == 0 ? sessao.horas.toInt() : sessao.horas.toStringAsFixed(1)}h',
                    style: const TextStyle(
                      color: Color(0xFFFF0000),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black26,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
