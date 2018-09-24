//
//  CalculatorBrain.swift
//  CalculatorApp
//
//  Created by Oguz Bayral on 24.09.2018.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//

import Foundation

class CalculatorBrain{

    private var accumulator = 0.0
    func setOperand(operand: Double){
      accumulator = operand
    }
    func performOperation(symbol: String){
        switch symbol{
        case "π":
            accumulator = Double.pi
        case "√":
            accumulator = sqrt(accumulator)
        case "e":
            accumulator = M_E
        case "AC":
            accumulator = 0
        default:
            break
        }
    }
    var result:Double{
        get{
            return accumulator
        }
    }
    
}
