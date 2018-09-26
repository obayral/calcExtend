//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Oguz Bayral on 22.09.2018.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
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
        print("\(label.text!) label value")
        print("\(displayValue) label value")
        
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







