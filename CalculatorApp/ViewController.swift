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
    
    private var userCurrentlyTyping: Bool = false
    
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
    
    private var displayValue: Double{
        get{
            return Double(label.text!)!
        }
        set{
            label.text! = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction private func performOperation(_ sender: UIButton) {
        if userCurrentlyTyping {
            brain.setOperand(operand: displayValue)
            userCurrentlyTyping = false
        }
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    }
}





