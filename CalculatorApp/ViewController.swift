//
//  ViewController.swift
//  CalculatorApp
//  StudentID: 301029119
//  Created by Oguz Bayral on 22.09.2018.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//  Version 1.0.0
//  CalculatorApp is created by Oguz Bayral to perfrom some mathematical operations.
//  CalculatorApp contains basic binary operations as well as some advanced unary operations.

import UIKit

//ViewController class declaration. It controls the UI and provide the view to respond to user.
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBOutlet weak var buttonEuler: UIButton!
    @IBOutlet weak var buttonPi: UIButton!
    @IBOutlet weak var buttonCos: UIButton!
    @IBOutlet weak var buttonSin: UIButton!
    @IBOutlet weak var buttonPerCent: UIButton!
    @IBOutlet weak var buttonNegate: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonMultiply: UIButton!
    @IBOutlet weak var buttonEquals: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonDecimal: UIButton!
    @IBOutlet weak var buttonSquare: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    //Double var declaration in order to represent the number in stack(number that waits to be operated)
    private var numberInStack = 0.0
    //Unwrapped String var declation to represent the previous operation
    private var previousOperation:String!
    //Double var declaration in order to represent the current number
    private var currentValue = 0.0
    //Unwrapped String var declation to represent the current operation
    private var currentOperation:String!
    
    //function that sets the operand value to currentValue
    func setOperand(operand: Double){
        currentValue = operand
    }
    
    //function that enables all the buttons
    func enableButtons(){
        buttonCos.isEnabled = true
        buttonSin.isEnabled = true
        buttonPerCent.isEnabled=true
        buttonNegate.isEnabled=true
        buttonEuler.isEnabled=true
        buttonPi.isEnabled=true
        buttonDivide.isEnabled=true
        buttonPlus.isEnabled=true
        buttonMinus.isEnabled=true
        buttonMultiply.isEnabled=true
        buttonEquals.isEnabled=true
        buttonSquare.isEnabled=true
        buttonDecimal.isEnabled=true
        button0.isEnabled=true
        button1.isEnabled=true
        button2.isEnabled=true
        button3.isEnabled=true
        button4.isEnabled=true
        button5.isEnabled=true
        button6.isEnabled=true
        button7.isEnabled=true
        button8.isEnabled=true
        button9.isEnabled=true
    }
    
    //function that disables all the buttons
    func disableButtons(){
        buttonCos.isEnabled = false
        buttonSin.isEnabled = false
        buttonPerCent.isEnabled=false
        buttonNegate.isEnabled=false
        buttonEuler.isEnabled=false
        buttonPi.isEnabled=false
        buttonDivide.isEnabled=false
        buttonPlus.isEnabled=false
        buttonMinus.isEnabled=false
        buttonMultiply.isEnabled=false
        buttonEquals.isEnabled=false
        buttonSquare.isEnabled = false
        buttonDecimal.isEnabled=false
        button0.isEnabled=false
        button1.isEnabled=false
        button2.isEnabled=false
        button3.isEnabled=false
        button4.isEnabled=false
        button5.isEnabled=false
        button6.isEnabled=false
        button7.isEnabled=false
        button8.isEnabled=false
        button9.isEnabled=false
    }
    
    //computed propert declaration, the result can only be gotten
    var result:Double{
        get{
            return currentValue
        }
    }
    
    //Boolean Var declaration whether user is writing or not
    private var userCurrentlyTyping = false
    //Boolean Var declaration whether a decimal sign exists or not
    private var hasDecimal = false
    
    //the function that recognizes the digit via UIButton
    @IBAction private func touchDigit(_ sender: UIButton) {
        
        //Declaring a digit constant, it is an unwrapped optional String
        let digit = sender.currentTitle!
        
        //if decimal sign exists in the label then hasDecimal is set to true
        if label.text!.contains("."){
            hasDecimal = true
        }
        
        //Appending algorithm for numbers and for the decimal point
        if userCurrentlyTyping{
            if hasDecimal == false{
                let textCurrentlyInDisplay = label.text!
                label.text = textCurrentlyInDisplay + digit
                if digit == "."{
                    hasDecimal = true
                }
            }else if hasDecimal == true && digit != "."{
                label.text = label.text! + digit
            }
        } else{
            if hasDecimal == false && digit == "." {
                label.text = label.text! + digit
                hasDecimal = true
            }else if digit != "." {
                label.text = digit
            }
        }
        userCurrentlyTyping = true
    }
    
    //Core Calculating Algorithm
    @IBAction func operate(_ sender: UIButton) {
        if userCurrentlyTyping {
            setOperand(operand: displayValue)
            userCurrentlyTyping = false
        }
        let operation = sender.currentTitle!
        switch operation{
            
        //Binary Operations, if it is the first time with the op, then currentValue becomes numberInStack
        case "+":
            print("pressed")
            if previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "+"
        case "-":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "-"
        case "x":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "x"
        case "/":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "/"
            
        //performing the BinaryOperations
        case "=":
            if currentOperation == "+"{
                previousOperation = "+"
                performBinaryOperation(operation:{$0+$1})
            }else if currentOperation == "-"{
                previousOperation = "-"
                performBinaryOperation(operation:{$0-$1})
            }
            else if currentOperation == "x"{
                previousOperation = "x"
                performBinaryOperation(operation:{$0*$1})
            }
            else if currentOperation == "/"{
                previousOperation = "/"
                performBinaryOperation(operation:{$0/$1})
            }
            
        //Unary Operations, if it is the first time with the op, then currentValue becomes numberInStack
        case "√":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            //square root of negative numbers are represented with imaginary numbers
            if numberInStack.isLess(than: 0.0){
                label.text! = String(sqrt(numberInStack * -1)) + "i"
                disableButtons()
            }
            else{
                performUnaryOperation(operation:{sqrt($0)})
                currentOperation = "√"
            }
        case "cos":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            performUnaryOperation(operation:{cos($0)})
            currentOperation = "cos"
        case "sin":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            performUnaryOperation(operation:{sin($0)})
            currentOperation = "sin"
        case "%":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            performUnaryOperation(operation:{($0/100)})
            currentOperation = "%"
        case "+/-":
            if previousOperation==nil{
                numberInStack=currentValue
            }
            performUnaryOperation(operation: {($0 * -1)})
            currentOperation = "+/-"
        case "AC":
            currentValue = 0.0
            numberInStack = 0.0
            displayIntValue = 0
            previousOperation = nil
            currentOperation = nil
            hasDecimal = false
            enableButtons()
        case "π":
            currentValue = Double.pi
            displayValue = Double.pi
            hasDecimal = true
        case "e":
            currentValue = M_E
            displayValue = M_E
            hasDecimal = true
        default: break
        }
    }
    
    //Declaring a type func which takes 2 Double parameters and returns 1 Double parameter.
    //This is for binary operations.
    func performBinaryOperation(operation:(Double,Double)->Double){
        displayValue = operation(numberInStack,currentValue)
        numberInStack = displayValue
    }
    
    //Declaring a type func which takes 1 Double parameter and returns 1 Double parameter.
    //This is for binary operations.
    func performUnaryOperation(operation:(Double)->Double){
        displayValue = operation(numberInStack)
        numberInStack = displayValue
        currentValue = displayValue
        previousOperation = currentOperation
    }
    
    //Declaring a computed property in type Double to trace the value of displayLabel
    private var displayValue: Double{
        get{
            return Double(label.text!)!
        }
        set{
            label.text! = String(newValue)
            userCurrentlyTyping = false
        }
    }
    
    //Declaring a computed property in type Int to trace the value of displayLabel
    var displayIntValue: Int{
        get{
            return Int(label.text!)!
        }
        set{
            label.text! = String(newValue)
            userCurrentlyTyping = false
        }
    }
}







