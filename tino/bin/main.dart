import '../lib/colorCode.dart' as color;
import 'kembangApi.dart' as firework; // Correctly importing kembangApi.dart
import 'dart:async';
import 'dart:math';
import 'dart:io';

// ANSI escape codes for background colors
const List<String> backgroundColors = [
  "\x1B[40m", // Black
  "\x1B[41m", // Red
  "\x1B[42m", // Green
  "\x1B[43m", // Yellow
  "\x1B[44m", // Blue
  "\x1B[45m", // Magenta
  "\x1B[46m", // Cyan
  "\x1B[47m", // White
];

List<int> getScreenSize() {
  return [stdout.terminalColumns, stdout.terminalLines];
}

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
}

Future<void> delay(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}

int randomMax(int max) {
  return Random().nextInt(max);
}

void main() async {
  clearScreen();
  stdout.write("Masukkan Jumlah kembang Api: ");
  int? jumlahKembangApi = (int.parse(stdin.readLineSync()!));
  jumlahKembangApi = jumlahKembangApi < 1 ? 1 : jumlahKembangApi;

  // Set random background color
  String selectedBackground = backgroundColors[Random().nextInt(backgroundColors.length)];
  stdout.write(selectedBackground); // Change terminal background color

  clearScreen();
  for (int j = 0; j < jumlahKembangApi; j++) {
    int minHeight = getScreenSize()[1] ~/ 3;
    int randomX = randomMax(getScreenSize()[0]);
    int randomY = random(minHeight, getScreenSize()[1] - minHeight);
    String randomColor = color.getRandomColor();
    
    if (j == 0) {
      randomX = getScreenSize()[0] ~/ 2;
      randomY = getScreenSize()[1] ~/ 2;
    }

    // Invoke the firework animation
    await firework.kembangApi(randomX, randomY, randomColor);
  }

  clearScreen();
}
