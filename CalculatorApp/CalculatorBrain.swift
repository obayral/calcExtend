//
//  CalculatorBrain.swift
//  CalculatorApp
//
//  Created by Oguz Bayral on 24.09.2018.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var firstNumber:Double? = nil
    private var currentOperation:String! = nil
    private var accumulator = 0.0
    func setOperand(operand: Double){
      accumulator = operand
    }
    func sum(operand1:Double,operand2:Double)->Double{
        return operand1+operand2
    }
    func multiply(operand1:Double,operand2:Double)->Double{
        return operand1*operand2
    }
    func subtract(operand1:Double,operand2:Double)->Double{
        return operand1-operand2
    }
    var operandList = Array<Double>()
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
        case "+":
            firstNumber = accumulator
            currentOperation = "+"
        case "-":
            firstNumber = accumulator
            currentOperation = "-"
        case "*":
            firstNumber = accumulator
            currentOperation = "x"
        case "=":
            if currentOperation == "+"{
                accumulator=sum(operand1: firstNumber!, operand2: accumulator)
            }else if currentOperation == "x"{
                accumulator=multiply(operand1: firstNumber!, operand2: accumulator)
            }
            else if currentOperation == "-"{
                accumulator=subtract(operand1: firstNumber!, operand2: accumulator)
            }
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
