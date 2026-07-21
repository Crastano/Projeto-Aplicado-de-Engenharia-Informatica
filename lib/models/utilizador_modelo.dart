// Enums
import 'package:pei/enums/tipo_utilizador.dart';

class UtilizadorModelo {
  const UtilizadorModelo({
    required this.id,
    this.email,
    this.tipo = TipoUtilizador.naoRegistado,
  });

  final int id;
  final String? email;
  final TipoUtilizador tipo;
}
