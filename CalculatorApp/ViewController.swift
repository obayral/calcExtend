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
        let operation = sender.currentTitle!
        switch operation{
        case "+":
            performBinaryOperation(operation:{$0+$1})
        case "-":
            performBinaryOperation(operation:{$1-$0})
        case "x":
            performBinaryOperation(operation:{$0*$1})
        case "/":
            performBinaryOperation(operation:{$1/$0})
        case "√":
            performUnaryOperation(operation:{sqrt($0)})
        case "AC":
            operandStack.removeAll()
            displayIntValue = 0
            hasDecimal = false
        case "π":
            displayValue = Double.pi
            hasDecimal = true
        case "e":
            displayValue = M_E
            hasDecimal = true
        case "cos":
            performUnaryOperation(operation:{cos($0)})
        case "sin":
            performUnaryOperation(operation:{sin($0)})
        case "%":
            performUnaryOperation(operation:{($0/100)})
        case "+/-":
            displayValue.negate()
        default: break
        }
    
    }
    
    //Declaring a type func which takes 2 Double parameters and returns 1 Double parameter.
    //This is for binary operations.
    func performBinaryOperation(operation:(Double,Double)->Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    //Declaring a type func which takes 1 Double parameter and returns 1 Double parameter.
    //This is for binary operations.
    func performUnaryOperation(operation:(Double)->Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    //Array Declaration to put the numbers in a stack
    var operandStack = Array<Double>()
    
    //When enter button pressed, the value within Label is appended to the stack
    @IBAction func enter() {
        userCurrentlyTyping = false
        operandStack.append(displayValue)
        print("operandStack \(operandStack)")
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







