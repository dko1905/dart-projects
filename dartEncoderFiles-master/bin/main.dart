import 'dart:io';
import 'dart:convert';

import 'package:dartEncoderFiles/dartBase32Converter.dart' as dart_base;

bool debug = false;

String encode(String argument){
	if(debug)print("Argument = $argument");
	final file = new File(argument);
	print("Making list"); // 		1
	List<int> byteList = new List();

	print("Reading file "); // 		2
	byteList = file.readAsBytesSync();

	if(debug)print("byteList = $byteList");

	String output = "";
	print("In the loop"); // 		3
	print("loop times = ${byteList.length}");

	for(int n = 0; n < byteList.length; n++){
		if(debug)print("byteList[n] = ${byteList[n]}");
		if(n > 0){
			output += "=";
		}

		if(n == byteList.length%(byteList.length/20)){
			print((byteList.length~/n)*100);
		}

		output += dart_base.toBase32(byteList[n]);
	}
	print("loop is done "); // 		4
	if(debug)print("output = $output");
	return output;
}

List<int> decode(String input){
	List<int> charList = List();
	List<String> temp;
	temp = input.split("=");

	for(int n = 0; n < temp.length; n++){
		charList.add(dart_base.toBase10(temp[n]));
	}
	if(debug)print("charList = $charList");
	return charList;
}

main(List<String> arguments) {
	dart_base.makeMap();

	print("Press 1 for encoding and 2 for decoding");
	var line = stdin.readLineSync(encoding: utf8);
	if(line == "1"){
		print("Write name of file you want to encode:");
		line = stdin.readLineSync(encoding: utf8);
		var encoded = encode(line);
		new File('encoded.txt').writeAsStringSync(encoded);

		print("Done");
		line = stdin.readLineSync(encoding: utf8);

	} else{
		print("Write filename to decode :");
		var decodeFilename = stdin.readLineSync(encoding: utf8);
		print("Write filename to save file with:");
		var filename = stdin.readLineSync(encoding: utf8);

		line = File(decodeFilename).readAsStringSync();

		new File(filename).writeAsBytesSync(decode(line));

		print("Done");
		line = stdin.readLineSync(encoding: utf8);
	}

}
