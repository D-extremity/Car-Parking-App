import 'dart:math';

String getCode() {
  String code = "";
  const String alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  const String numerics = "0123456789";
  code += alphabets[Random().nextInt(alphabets.length)];
  code += alphabets[Random().nextInt(alphabets.length)];
  code += numerics[Random().nextInt(numerics.length)];
  code += numerics[Random().nextInt(numerics.length)];
  List<String> codeCharacters = code.split("");
  codeCharacters.shuffle();
  code = codeCharacters.join();
  return code;
}
