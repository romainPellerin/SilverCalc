import  java.util
import  android.app
import  android.content
import  android.os
import  android.util
import  android.view
import  android.widget

public class MainActivity: Activity {

	var buttons : ArrayList<android.view.View>!
	var calc : Calculator = Calculator()
	
	var tf : TextView!
	
	var NUMBER_ACTION = 0
	var OPERATOR_ACTION = 1
	var DOT_ACTION = 2
	var EQUAL_ACTION = 3
	var lastAction = NUMBER_ACTION
	

	public override func onCreate(savedInstanceState: Bundle!) {
		super.onCreate(savedInstanceState)
		ContentView = R.layout.main
		buttons = (findViewById(R.id.calcLayout) as! RelativeLayout).getTouchables()
		
			  
		alert("alive")
		setupButtons()
	}
	
	public func alert(message: String) {
		var  alertDialog:AlertDialog = AlertDialog.Builder(self).create();
		alertDialog.setTitle("Alert")
		alertDialog.setMessage(message)
		alertDialog.setButton("OK", DialogInterface.OnClickListener() {
		})
		alertDialog.setIcon(R.drawable.icon);
		alertDialog.show();
	}
	
	func setupButtons(){
		
	   // parse buttons and set the relevant listeners to each button
	   for bt in buttons {
			
			if bt is Button {
							
				var btText: String = (bt as! Button).getText() as! String

				// bind listeners to buttons
				if btText == "x" {
					bt.setOnClickListener{multiply(bt)}
				}
				else if btText == "/" {
					bt.setOnClickListener{divide(bt)}
				}
				else if btText == "-" {
					bt.setOnClickListener{minus(bt)}
				}
				else if btText == "+" {
					bt.setOnClickListener{add(bt)}
				}
				else if btText == "C" {
					bt.setOnClickListener{clear(bt)}
				}
				else if btText == "+/-" {
					bt.setOnClickListener{invert(bt)}
				}
				else if btText == "=" {
					bt.setOnClickListener{equal(bt)}
				}
				else if btText == "," {
					bt.setOnClickListener{dot(bt)}
				}
				else {
					bt.setOnClickListener{numberPressed(btText)}
				}
			}
			else if bt is TextView {  
				tf = bt as! TextView
				tf.Text = "0.0"
			}
			
		}
	}
	
	func numberPressed(nb:String)
	{
		lastAction = NUMBER_ACTION
		
		var c : Int32 = nb[0]-48
		
		// calc will compose number with new int part
		calc.composeNumber(c)
		tf.Text = calc.getStringValue()
	}
	
	func multiply(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.multiply()
		tf.setText(calc.getStringValue())
		alert("multiply")
	}
	
	func divide(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.divide()
		tf.setText(calc.getStringValue())
	}
	
	func minus(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.minus()
		tf.setText(calc.getStringValue())
	}
	
	func add(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.add()
		tf.setText(calc.getStringValue())
	}
	
	func equal(sender:View!)
	{
		lastAction = EQUAL_ACTION
		calc.process()
		tf.setText(calc.getStringValue())
	}
	
	func clear(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.clearNumber()
		tf.setText(calc.getStringValue())
	}
	
	func invert(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.invert()
		tf.setText(calc.getStringValue())
	}
	
	func dot(sender:View!)
	{
		lastAction = OPERATOR_ACTION
		calc.afterdot = true
		alert("dot pressed")
	}
	
	public override func onCreateOptionsMenu(menu: Menu!) -> Boolean{
		// Inflate the menu; this adds items to the action bar if it is present.
		//getMenuInflater().inflate(R.menu.menu_main, menu)
		return true
	}

	public override func onOptionsItemSelected(item: MenuItem!) -> Boolean{
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		var id : Integer = item.getItemId()

		//noinspection SimplifiableIfStatement
		/*if (id == R.id.action_settings) {
			return true
		}*/

		return super.onOptionsItemSelected(item)
	}
	
	
	
}
