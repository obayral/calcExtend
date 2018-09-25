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
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userCurrentlyTyping{
            let textCurrentlyInDisplay = label.text!
            label.text = textCurrentlyInDisplay + digit
        } else{
            label.text = digit
            userCurrentlyTyping = true
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
        case "π":
            displayValue = Double.pi
        case "e":
            displayValue = M_E
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
    private var displayIntValue: Int{
        get{
            return Int(label.text!)!
        }
        set{
            label.text! = String(newValue)
            userCurrentlyTyping = false
        }
        
    }
    
}





