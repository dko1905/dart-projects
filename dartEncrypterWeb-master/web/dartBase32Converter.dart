import 'dart:math';
import 'package:dartToCharCode/dartToCharCode.dart' as dart_char;
import 'simpleEncode.dart' as simple_encoder;

bool debug = false;

//the base10 to base32 map
Map baseMap = new Map(); //int to base 32
Map baseInvMap = new Map(); //base32 to int

Map inverse(Map f) {
	return f.map( (k, v) => MapEntry(v, k) );
}

void makeMap(){
	//0 = 0 to 9 = 9
	for(int n = 0; n <= 9; n++){
		baseMap[n] = n.toString();
	}
	// 10 = a and rest
	baseMap[10] = "a";
	baseMap[11] = "b";
	baseMap[12] = "c";
	baseMap[13] = "d";
	baseMap[14] = "e";
	baseMap[15] = "f";
	baseMap[16] = "g";
	baseMap[17] = "h";
	baseMap[18] = "i";
	baseMap[19] = "j";
	baseMap[20] = "k";
	baseMap[21] = "m";
	baseMap[22] = "n";
	baseMap[23] = "o";
	baseMap[24] = "p";
	baseMap[25] = "q";
	baseMap[26] = "r";
	baseMap[27] = "s";
	baseMap[28] = "t";
	baseMap[29] = "u";
	baseMap[30] = "v";
	baseMap[31] = "w";
	baseMap[32] = "x";
	baseMap[33] = "y";
	baseMap[34] = "z";

	baseMap[35] = "A";
	baseMap[36] = "B";
	baseMap[37] = "C";
	baseMap[38] = "D";
	baseMap[39] = "E";
	baseMap[40] = "F";
	baseMap[41] = "G";
	baseMap[42] = "H";
	baseMap[43] = "I";
	baseMap[44] = "J";
	baseMap[45] = "K";
	baseMap[46] = "M";
	baseMap[47] = "N";
	baseMap[48] = "O";
	baseMap[49] = "P";
	baseMap[50] = "Q";
	baseMap[51] = "R";
	baseMap[52] = "S";
	baseMap[53] = "T";
	baseMap[54] = "U";
	baseMap[55] = "V";
	baseMap[56] = "W";
	baseMap[57] = "X";
	baseMap[58] = "Y";
	baseMap[59] = "Z";

	baseMap[60] = "!";
	baseMap[61] = "@";
	baseMap[62] = "%";
	baseMap[63] = "&";
	baseMap[64] = "/";
	baseMap[65] = "{";
	baseMap[66] = "}";
	baseMap[67] = "[";
	baseMap[68] = "]";
	baseMap[69] = "(";
	baseMap[70] = ")";
	baseMap[71] = ":";
	baseMap[72] = "+";
	baseMap[73] = "-";
	baseMap[74] = "?";
	baseMap[75] = "´";
	baseMap[76] = "`";
	baseMap[77] = "*";
	baseMap[78] = "'";

	baseMap[79] = "å";
	baseMap[80] = "æ";
	baseMap[81] = "ø";
	baseMap[82] = "_";
	baseMap[83] = ";";
	baseMap[84] = ".";
	baseMap[85] = ",";

	//make inverce map
	baseInvMap = inverse(baseMap);
}

List<int> doThings(int num){ //converting to new base
	if(debug)print("num before = $num");
	int remeinder = 0;
	List<int> remeinders = new List();
	do{
		remeinder = num%baseMap.length;
		num = num~/baseMap.length;
		if(debug)print("num = $num");
		remeinders.add(remeinder);
		if(debug)print("Remeinder = $remeinder");
	}while(num > 0);
	if(debug)print("remeinders = $remeinders");
	return remeinders;
}

String toBase32(int num){
	try{String result = "";
		List<int> numList = doThings(num); //return list of numbers that we need to make to chars
		for(int n = numList.length-1; n >= 0; n--){ //to new base char
			result += baseMap[numList[n]];
		}
		return result;
	}catch(e){
		print("###### Error on toBase32 function : $e");
	}
}

String toBase32Str(String input){
	if(debug)print("#	Input = $input");

	String outputStr = "";
	List<int> charNumberArray = dart_char.stringToIntList(input);
	charNumberArray = simple_encoder.encodeSimple(charNumberArray);

	if(debug)print("#	charNumberArray = $charNumberArray");

	try{
	for(int n = 0; n < charNumberArray.length; n++){
		if(n > 0){
			outputStr += "=";
		}
		outputStr += toBase32(charNumberArray[n]);

		if(debug)print("		# n = $n  outputStr = $outputStr");

	}}catch(e){
		print("###### Error in function toBase32Str after stringToIntList");
		print(charNumberArray.toString());
		print(e);
	}

													if(debug)print("#	outputStr = $outputStr");
	return outputStr;
}

String toBase10Str(String input){
	if(debug)print("#	Input = $input");
	List<String> charArray = input.split("=");
	if(debug)print("#	charArray = $charArray");

	List<int> outputArray = new List();
	for(int n = 0; n < charArray.length; n++){
		outputArray.add(toBase10(charArray[n]));
	}
	outputArray = simple_encoder.decodeSimple(outputArray);
	String output = "";
	for(int n = 0; n < charArray.length; n++){
		output += new String.fromCharCode(outputArray[n]);
	}
													if(debug)print("#	output = $output");
	//make to chars

	return output;
}

int toBase10(String num){
	try{int result = 0;
	if(num.length > 1){
		for(int n = num.length-1; n >= 0; n--){ //go throuag all in string with end first
			String character = num[n];
			if(debug)print("Char : $character");
			if(debug)print("Num : $n");
			if(debug)print("result should be: ${baseInvMap[character]}") ;
			if(debug)print("test : ${num.length-1}");
			result += baseInvMap[character] * pow(baseMap.length, num.length-1-n);
			if(debug)print("result : $result") ;
		}
		return result;
	}
	else{ //if more than one charecter
		return baseInvMap[num];
	}}catch(e){
		print("###### Error in toBase10 function : $e");
	}
}
