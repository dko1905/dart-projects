import 'package:dartBase32Converter/dartBase32Converter.dart' as dartBase32Converter;
import 'dart:io';

main(List<String> arguments) {
	print("Starting!");
	print("Making map!");
	dartBase32Converter.makeMap();
	print("Type input as int");
	var line = stdin.readLineSync();
	print("Your input is = $line");
	print("to base 32 = ${dartBase32Converter.toBase32(int.parse(line))}");

	print("\nDone!");
}
