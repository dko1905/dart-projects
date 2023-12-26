bool debug = false;

int specialNum = 252;

List<int> encodeSimple(List<int> input){//make new encoding thingy
	List<int> output = [];
	for(int n = 0; n < input.length; n++){
		output.add( input[n]*(n+1) );

		if(debug)print(" n = $n  input = $input  output = $output");
	}
	return output;
}

List<int> decodeSimple(List<int> input){//make new encoding thingy
	List<int> output = [];
	for(int n = 0; n < input.length; n++){
		output.add( input[n]~/(n+1) );

		if(debug)print(" n = $n  input = $input  output = $output");
	}
	return output;
}

