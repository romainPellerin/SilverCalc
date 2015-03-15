import UIKit

@IBObject class RootViewController : UIViewController {
	
	var buttons : [UIButton] = []
	var calc : Calculator = Calculator()
	var tf : UITextField!

	@IBOutlet var tf_numb : UITextField!

	var result = 0
	var resultDisplayed = ""
	
	var lastAction = NUMBER_ACTION
	
	var NUMBER_ACTION = 0
	var OPERATOR_ACTION = 1
	var DOT_ACTION = 2
	var EQUAL_ACTION = 3


	public override func viewDidLoad() {

		super.viewDidLoad()	
		
		// Do any additional setup after loading the view.		
		setupButtons()
	}
	
	func alert(s:String){
	   let alert = UIAlertView()
	   alert.title = "Calc alert"
	   alert.message = s
	   alert.addButtonWithTitle("Ok")
	   alert.show()
	}
	
	func setupButtons(){
		
		// discver buttons from view in Main.storyboard
		// instead of duplicate buttons declarations
		for bt in self.view.subviews {
			if bt is UIButton {  
				// set buttons style
				bt.layer.cornerRadius = 5.0;
				bt.layer.borderColor = UIColor(red: 191.0/255, green: 188.0/255, blue:  188.0/255, alpha: 1.0).CGColor
				bt.layer.borderWidth = 0.5
			
				// bund methods to buttons
				if bt.titleLabel.text == "x" {
					bt.addTarget(self, action: "multiply:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "/" {
					bt.addTarget(self, action: "divide:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "-" {
					bt.addTarget(self, action: "minus:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "+" {
					bt.addTarget(self, action: "add:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "C" {
					bt.addTarget(self, action: "clear:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "+/-" {
					bt.addTarget(self, action: "invert:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "=" {
					bt.addTarget(self, action: "equal:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else if bt.titleLabel.text == "," {
					bt.addTarget(self, action: "dot:", forControlEvents: UIControlEvents.TouchUpInside)
				}
				else {
					bt.addTarget(self, action: "numberPressed:", forControlEvents: UIControlEvents.TouchUpInside)
				}
			}
			else if bt is UITextField {  
				tf = bt
				tf.text = "0.0"
				tf.enabled = NO
				tf.textAlignment = .Right
			}
			
			buttons.append(bt)
			
		}
	}

	public override func didReceiveMemoryWarning() {

		super.didReceiveMemoryWarning();
		// Dispose of any resources that can be recreated.
	}
	
	func numberPressed(sender:UIButton!)
	{
		lastAction = NUMBER_ACTION
		
		var nb:String = sender.titleLabel.text 
		var c : Int32 = nb[0]-48
		
		// calc will compose number with new int part
		calc.composeNumber(c)
		tf.text = calc.getStringValue()
	}
	
	func multiply(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.multiply()
		tf.text = calc.getStringValue()
	}
	
	func divide(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.divide()
		tf.text = calc.getStringValue()
	}
	
	func minus(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.minus()
		tf.text = calc.getStringValue()
	}
	
	func add(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.add()
		tf.text = calc.getStringValue()
	}
	
	func equal(sender:UIButton!)
	{
		lastAction = EQUAL_ACTION
		calc.process()
		tf.text = calc.getStringValue()
	}
	
	func clear(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.clearNumber()
		tf.text = calc.getStringValue()
	}
	
	func invert(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.invert()
		tf.text =  calc.getStringValue()
	}
	
	func dot(sender:UIButton!)
	{
		lastAction = OPERATOR_ACTION
		calc.afterdot = true
	}

}