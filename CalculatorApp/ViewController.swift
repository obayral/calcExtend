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
    
    private var numberInStack = 0.0
    private var previousOperation:String!
    private var currentValue = 0.0
    private var currentOperation:String!
    
    func setOperand(operand: Double){
        currentValue = operand
    }
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
            }else{
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
        case "+":
            if currentOperation != previousOperation || previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "+"
            
        case "-":
            if currentOperation != previousOperation || previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "-"
        case "x":
            if currentOperation != previousOperation || previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "x"
        case "/":
            if currentOperation != previousOperation || previousOperation==nil{
                numberInStack=currentValue
            }
            currentOperation = "/"
        case "√":
            currentOperation = "√"
            if currentOperation != previousOperation || previousOperation==nil{
                numberInStack=currentValue
            }
            if numberInStack.isLess(than: 0.0){
                label.text! = String(sqrt(currentValue)) + "i"
            }
            else{
                performUnaryOperation(operation:{sqrt($0)})
            }
            previousOperation = currentOperation
        case "cos":
            numberInStack=currentValue
            performUnaryOperation(operation:{cos($0)})
            previousOperation = "cos"
        case "sin":
            numberInStack=currentValue
            performUnaryOperation(operation:{sin($0)})
            previousOperation = "sin"
        case "%":
            numberInStack=currentValue
            performUnaryOperation(operation:{($0/100)})
            previousOperation = "%"
        case "+/-":
            print("\(numberInStack)numberstack hoho")
            if previousOperation == nil{
                numberInStack=currentValue
                print("buraya girdi")
            }
            print("buraya girmedi")
            print("\(numberInStack)numberstack hehe")
             print("\(currentValue)currentvalueee")
            performUnaryOperation(operation: {($0 * -1)})
            previousOperation = "+/-"
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
        case "=":
            if label.text!.contains("i")  {
                label.text! = "Error"
            }
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
        if previousOperation == nil {
            displayValue = operation(numberInStack)
        }else if previousOperation != nil{
            print("\(numberInStack)numberstack lala")
            displayValue = operation(currentValue)
            print("\(displayValue) displayvalue lulu")
        }
        numberInStack = displayValue
        currentValue = displayValue
        print("\(numberInStack) numberstack hehe")
       
    }
    
    //Array Declaration to put the numbers in a stack
    
    
    //When enter button pressed, the value within Label is appended to the stack
    
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







