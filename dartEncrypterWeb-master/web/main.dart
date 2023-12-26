import 'dart:html';
import 'dartBase32Converter.dart' as dart_Base32;
import 'simpleEncode.dart' as simple_encoder;

void checkForButttonEvent(List<ButtonElement> buttons) async {
	InputElement input = querySelector("#inputDiv");
	InputElement output = querySelector("#outputDiv");
	InputElement input2 = querySelector("#inputDiv2");
	InputElement output2 = querySelector("#outputDiv2");
	TextAreaElement input3 = querySelector("#inputDiv3");
	TextAreaElement output3 = querySelector("#outputDiv3");
	TextAreaElement input4 = querySelector("#inputDiv4");
	TextAreaElement output4 = querySelector("#outputDiv4");
	for(int n = 0; n < buttons.length; n++){
		buttons[n].onClick.listen(
			(event){
				if(buttons[n].id == "submitButton"){
					output.value = dart_Base32.toBase32(int.parse(input.value));
				}
				else if(buttons[n].id == "submitButton2"){
					output2.value = dart_Base32.toBase10(input2.value).toString();
				}
				else if(buttons[n].id == "submitButton3"){
					//print("input3.value.toString()   = ${input3.value.toString()}");
					output3.value = dart_Base32.toBase32Str(input3.value.toString()).toString();
					output3.select();
					document.execCommand("copy");
				}
				else if(buttons[n].id == "submitButton4"){
					//print("input4.value.toString()   = ${input4.value.toString()}");
					output4.value = dart_Base32.toBase10Str(input4.value.toString());
					output4.select();
					document.execCommand("copy");
				}
			}
		);
	}
}

void main() {

	dart_Base32.makeMap();


	checkForButttonEvent([querySelector('#submitButton'), querySelector('#submitButton2'), querySelector('#submitButton3'), querySelector('#submitButton4')]);
}
