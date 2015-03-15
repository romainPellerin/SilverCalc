import Sugar

class Calculator{
	var firstMbrs : Sugar.Collections.List<Double> = Sugar.Collections.List<Double>()
	var secondMbrs : Sugar.Collections.List<Double> = Sugar.Collections.List<Double>()
	var value: Double = 0.0
	var mem: Double = 0.0
	
	var inverted : Boolean = false
	var afterdot : Boolean = false
	
	var op: Integer = -1
	static let ADD_OPERATOR : Integer = 0
	static let MINUS_OPERATOR : Integer = 1
	static let MULTIPLY_OPERATOR : Integer = 2
	static let DIVIDE_OPERATOR : Integer = 3


	// add 2 numbers
	func add(){
		storeInMem()
		op = ADD_OPERATOR
	}
	
	func minus(){
		storeInMem()
		op = MINUS_OPERATOR
	}
	
	func multiply(){
		storeInMem()
		op = MULTIPLY_OPERATOR
	}
	
	func divide(){
		storeInMem()
		op = DIVIDE_OPERATOR
	}
	
	func process(){
		switch op {
			case ADD_OPERATOR: 
				value = mem+value
			case MINUS_OPERATOR: 
				value = mem-value
			case MULTIPLY_OPERATOR: 
				value = mem*value
			case DIVIDE_OPERATOR: 
				if value == 0 {
					value = mem
				}
				else {
					value = mem/value
				}
			default: 
		}
		
		op = -1
	}
	
	/** IN-MEMORY NUMBER MANAGEMENT **/
	
	// add a char to the in memory number
	func composeNumber(a:Double){
		if (a == ","){
			
		}
		else {
			if (afterdot){
				secondMbrs.Add(a)
			}
			else {
				firstMbrs.Add(a)
				
			}	  
		}
		
		computeDoubleValue()
	}
	
	// reinit in memory number
	func clearNumber(){
		firstMbrs.Clear()
		secondMbrs.Clear()
		afterdot = false
		inverted = false
		value = 0.0
	}
	

	// get the value of in memory number
	func getStringValue() -> String{

		var result: String = Convert.ToString(getDoubleValue())
		
		/*if inverted { 
			result = "-"+result
		}*/
		
		return result
	}
	
	func computeDoubleValue() {
		var fp : Double = 0.0
		
		if firstMbrs.Count > 0 {
			var l : Double = Convert.ToDouble(firstMbrs.Count)
			for c in firstMbrs {
				var p:Double = Sugar.Math.Pow(10.0,l-1)
				fp += c*p
				l--;
			}
		}
		
		 
		if secondMbrs.Count > 0 {
			var l : Double = 1.0
			for c in secondMbrs {
				var p:Double = Sugar.Math.Pow(0.1,l)
				fp += c*p
				l++;
			}
		}

		var result: Double = fp 
		
		if inverted { 
			result *= -1.0
		}
		
		value = result
	}
	
	func getDoubleValue() -> Double{
		return value
	}
	
	func storeInMem(){
		mem = getDoubleValue()
		value = 0.0
		clearNumber()
	}
	
	func invert(){
		inverted = !inverted
		computeDoubleValue()
	}
}