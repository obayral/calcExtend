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
    
    private var userCurrentlyTyping = false
    private var hasDecimal = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
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
                userCurrentlyTyping = true
                hasDecimal = true
            }else{
                label.text = digit
                userCurrentlyTyping = true
            }
        }
        
    }
    
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
    
    func performBinaryOperation(operation:(Double,Double)->Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func performUnaryOperation(operation:(Double)->Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userCurrentlyTyping = false
        operandStack.append(displayValue)
        print("operandStack  \(operandStack)")
    }
    
    private var displayValue: Double{
        get{
            return Double(label.text!)!
        }
        set{
            label.text! = String(newValue)
            userCurrentlyTyping = false
        }
    }
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







