int stringToInt(String input){
	try{
		return input.codeUnitAt(0);
	}
	catch(e){
		print("Error in stringToInt, possybly becouse no char set: $e");
		return -1;
	}
}

List<int> stringToIntList(String input){
	List<int> charCodeList = [];
	for(int n = 0 ; n < input.length; n++){
		charCodeList.add(input.codeUnitAt(n));
	}
	return charCodeList;
}
