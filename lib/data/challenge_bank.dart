class GameQuestion {
  const GameQuestion(this.prompt, this.answers, this.correctIndex, this.symbol);

  final String prompt;
  final List<String> answers;
  final int correctIndex;
  final String symbol;
}

class ChallengeBank {
  static const _content = <String, List<GameQuestion>>{
    'Letras': [
      GameQuestion('¿Con qué letra empieza «LUNA»?', ['L', 'M', 'S'], 0, '🌙'),
      GameQuestion('¿Qué palabra rima con «casa»?', ['Taza', 'Perro', 'Sol'], 0, '🏠'),
      GameQuestion('¿Cuál es una vocal?', ['T', 'E', 'R'], 1, '🔤'),
      GameQuestion('Completa: MA _', ['R', 'NO', 'SA'], 1, '🧩'),
      GameQuestion('¿Qué palabra empieza con P?', ['Gato', 'Pelota', 'Luna'], 1, '⚽'),
      GameQuestion('¿Cuál es la última letra de «SOL»?', ['S', 'O', 'L'], 2, '☀️'),
      GameQuestion('¿Qué palabra tiene 3 letras?', ['Mariposa', 'Pan', 'Casa'], 1, '🍞'),
      GameQuestion('¿Cuál empieza igual que «ratón»?', ['Rana', 'Lana', 'Gato'], 0, '🐭'),
      GameQuestion('Ordena para formar una palabra: O-S-A', ['OSA', 'ASO', 'SAO'], 0, '🐻'),
      GameQuestion('¿Qué palabra rima con «león»?', ['Camión', 'Mesa', 'Flor'], 0, '🦁'),
      GameQuestion('¿Qué letra falta en «_ATO»?', ['P', 'U', 'E'], 0, '🐈'),
      GameQuestion('¿Cuál de estas palabras es un color?', ['Azul', 'Avión', 'Arroz'], 0, '🖍️'),
    ],
    'Números': [
      GameQuestion('¿Cuánto es 3 + 2?', ['4', '5', '6'], 1, '➕'),
      GameQuestion('¿Qué número viene después del 8?', ['7', '9', '10'], 1, '🔢'),
      GameQuestion('¿Cuánto es 10 - 4?', ['5', '6', '7'], 1, '➖'),
      GameQuestion('¿Cuál es el número más grande?', ['12', '7', '9'], 0, '📈'),
      GameQuestion('Hay 2 manzanas y agregas 3. ¿Cuántas hay?', ['4', '5', '6'], 1, '🍎'),
      GameQuestion('¿Qué número es par?', ['5', '7', '8'], 2, '🎲'),
      GameQuestion('¿Cuánto es 5 + 5?', ['10', '9', '11'], 0, '🖐️'),
      GameQuestion('¿Qué número falta? 2, 4, __, 8', ['5', '6', '7'], 1, '🪜'),
      GameQuestion('¿Cuántos lados tiene un triángulo?', ['3', '4', '5'], 0, '🔺'),
      GameQuestion('¿Cuánto es 9 - 2?', ['6', '7', '8'], 1, '🧮'),
      GameQuestion('¿Qué número es menor?', ['14', '11', '18'], 1, '🐢'),
      GameQuestion('Si tienes 4 globos y se va 1, ¿cuántos quedan?', ['2', '3', '4'], 1, '🎈'),
    ],
    'Memoria': [
      GameQuestion('Recuerda: 🐸 ⭐ 🐸. ¿Qué aparece al final?', ['⭐', '🐸', '🌙'], 1, '🧠'),
      GameQuestion('¿Qué figura se repite? 🔺 🔵 🔺', ['🔺', '🔵', '🟨'], 0, '👀'),
      GameQuestion('🍎 🌈 🐱. ¿Qué estaba en medio?', ['🍎', '🌈', '🐱'], 1, '🌈'),
      GameQuestion('¿Cuál pareja es idéntica?', ['🌙⭐', '🌙🌙', '⭐🌙'], 1, '🃏'),
      GameQuestion('¿Qué emoji falta? 🐶 🐱 __ 🐰', ['🐸', '🐹', '🐻'], 1, '🐹'),
      GameQuestion('¿Qué viste dos veces? 🍋 🍇 🍋', ['🍇', '🍋', '🍓'], 1, '🍋'),
      GameQuestion('☀️ 🌙 ⭐. ¿Qué iba primero?', ['⭐', '🌙', '☀️'], 2, '🌌'),
      GameQuestion('Encuentra el diferente: 🟣 🟣 🟢 🟣', ['🟣', '🟢', '🔵'], 1, '🔍'),
      GameQuestion('🐠 🐢 🐙. ¿Qué animal iba en medio?', ['🐢', '🦀', '🐬'], 0, '🐢'),
      GameQuestion('¿Cuántas estrellas viste? ⭐ ⭐ ⭐', ['2', '3', '4'], 1, '⭐'),
      GameQuestion('¿Qué par de colores es igual?', ['🔴🔵 / 🔵🔴', '🟢🟢 / 🟢🟢', '🟡🔴 / 🔴🔴'], 1, '🎨'),
      GameQuestion('🚗 🚲 🚌. ¿Qué iba al final?', ['🚗', '🚲', '🚌'], 2, '🛣️'),
    ],
    'Color Grid': [
      GameQuestion('¿Qué color resulta de mezclar azul y amarillo?', ['Verde', 'Morado', 'Naranja'], 0, '🎨'),
      GameQuestion('¿Cuál es el color del cielo despejado?', ['Azul', 'Rojo', 'Marrón'], 0, '☁️'),
      GameQuestion('¿Qué color falta? 🔴 🟡 🔴 __', ['🟢', '🟡', '🔵'], 1, '🟨'),
      GameQuestion('¿Qué color resulta de rojo y amarillo?', ['Verde', 'Naranja', 'Azul'], 1, '🍊'),
      GameQuestion('¿De qué color suele ser una hoja?', ['Verde', 'Violeta', 'Gris'], 0, '🍃'),
      GameQuestion('¿Qué color es más claro?', ['Amarillo', 'Negro', 'Azul marino'], 0, '💡'),
      GameQuestion('Completa: 🔵 🔴 🔵 __', ['🟢', '🔴', '🟡'], 1, '🔴'),
      GameQuestion('¿Qué color aparece al mezclar rojo y azul?', ['Morado', 'Verde', 'Naranja'], 0, '🟣'),
      GameQuestion('¿Cuál de estos objetos suele ser blanco?', ['Nube', 'Fresa', 'Limón'], 0, '☁️'),
      GameQuestion('¿Qué color contrasta más con el blanco?', ['Negro', 'Beige', 'Amarillo claro'], 0, '⚫'),
      GameQuestion('¿Cuál es una secuencia de colores cálidos?', ['Rojo, naranja, amarillo', 'Azul, verde, violeta', 'Azul, gris, blanco'], 0, '🔥'),
      GameQuestion('¿De qué color suele ser una berenjena madura?', ['Morado', 'Celeste', 'Rosa'], 0, '🍆'),
    ],
  };

  static List<GameQuestion> forWorld(String world) =>
      _content[world] ?? _content['Letras']!;
}
