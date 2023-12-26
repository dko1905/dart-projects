import 'dart:math';
import 'dart:io'; //for sleep and readAsBytes
import 'package:dartToCharCode/dartToCharCode.dart' as dartChar;

var debug = false;

//the base10 to base32 map
var base32Map = new Map(); //int to base 32
var base10Map = new Map(); //base32 to int

Map inverse(Map f) {
	return f.map( (k, v) => MapEntry(v, k) );
}

void makeMap(){
	//0 = 0 to 9 = 9
	for(int n = 0; n <= 9; n++){
		base32Map[n] = n.toString();
	}
	// 10 = a and rest
	base32Map[10] = "a";
	base32Map[11] = "b";
	base32Map[12] = "c";
	base32Map[13] = "d";
	base32Map[14] = "e";
	base32Map[15] = "f";
	base32Map[16] = "g";
	base32Map[17] = "h";
	base32Map[18] = "i";
	base32Map[19] = "j";
	base32Map[20] = "k";
	base32Map[21] = "m";
	base32Map[22] = "n";
	base32Map[23] = "o";
	base32Map[24] = "p";
	base32Map[25] = "q";
	base32Map[26] = "r";
	base32Map[27] = "s";
	base32Map[28] = "t";
	base32Map[29] = "u";
	base32Map[30] = "v";
	base32Map[31] = "w"; //rember 0
/*	base32Map[32] = "x";
	base32Map[33] = "y";
	base32Map[34] = "z";*/


	//make inverce map
	base10Map = inverse(base32Map);
}

List<int> doThings(int num){
	if(debug)print("num before = $num");
	int remeinder = 0;
	List<int> remeinders = new List();
	do{
		remeinder = num%32;
		num = num~/32;
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
		for(int n = numList.length-1; n >= 0; n--){
			result += base32Map[numList[n]];
		}
		return result;
	}catch(e){
		print("###### Error on toBase32 function : $e");
	}
}

String toBase32Str(String input){
	if(debug)print("#	Input = $input");

	String outputStr = "";
	List<int> charNumberArray = dartChar.stringToIntList(input);

	if(debug)print("#	charNumberArray = $charNumberArray");

	try{
	for(int n = 0; n < charNumberArray.length; n++){
		if(n > 0){
			outputStr += ":";
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
	List<String> charArray = input.split(":");
													if(debug)print("#	charArray = $charArray");
	String output = "";
	for(int n = 0; n < charArray.length; n++){
		output += new String.fromCharCode(toBase10(charArray[n]));
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
			if(debug)print("result should be: ${base10Map[character]}") ;
			if(debug)print("test : ${num.length-1}");
			result += base10Map[character] * pow(32, num.length-1-n);
			if(debug)print("result : $result") ;
		}
		return result;
	}
	else{ //if more than one charecter
		return base10Map[num];
	}}catch(e){
		print("###### Error in toBase10 function : $e");
	}
}
