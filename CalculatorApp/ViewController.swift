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
    
    var userCurrentlyTyping: Bool = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userCurrentlyTyping{
            let textCurrentlyInDisplay = label.text!
            label.text = textCurrentlyInDisplay + digit
        } else{
            label.text = digit
            userCurrentlyTyping = true
        }
    }
    
    var displayValue: Double{
        get{
           return Double(label.text!)!
        }
        set{
            label.text! = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userCurrentlyTyping = false
        if let mathSymbol = sender.currentTitle{
            switch mathSymbol{
            case "π":
                displayValue = Double.pi
            case "√":
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
    }
    
    
    
}

