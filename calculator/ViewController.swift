//
//  ViewController.swift
//  calculator
//
//  Created by Imran Jami on 6/3/15.
//  Copyright (c) 2015 Imran Jami. All rights reserved.
//

import UIKit
// EXTENSIONS TO USE //
extension Float {
    init(_ value: String){
        self = (value as NSString).floatValue
    }
}


class ViewController: UIViewController {
    
    @IBOutlet var calcLabel: UILabel! // where we display the numbers
    var currentNumber: Float = 0      // the number used for calculation
    var currentOperation: String = "" // the current operation (+ - * / = all clear)
    var numberBeingTyped: Bool = false// whether or not the last button pressed was a number
    var decimalUsed: Bool = false
    var numberCopy: Float = 0         // number copy for the copy button
    var copyUsed: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func copyButton(sender: AnyObject) {
        if copyUsed == false{
            numberCopy = currentNumber
            // somehow change the skin
        }
        else{
            calcLabel.text = calcLabel.text! + "\(numberCopy)"
        }
        
    }
    @IBAction func numberPressed(sender: AnyObject) -> Void {
        let button: UIButton = sender as! UIButton
        
        if  numberBeingTyped == false{ // because one of the numbers have been pressed.
            numberBeingTyped = true    //this part happens when we go from scratch to typing a number or...
            if button.tag == 16 && decimalUsed == false {
                decimalUsed = true
                calcLabel.text = "0."
            }else{
            calcLabel.text = ""}        // ...when we go from an operator to a number.
        }
        if button.tag == 16 && decimalUsed == false {
            calcLabel.text = calcLabel.text! + "."
        }
        if button.tag != 16{
            calcLabel.text = calcLabel.text! + "\(button.tag)"
        }
    }

    @IBAction func operationPressed(sender: AnyObject) -> Void {
        
        let button: UIButton = sender as! UIButton
        
        numberBeingTyped = false // because one of the operations have been pressed
        
        let calcValue:Float = Float(calcLabel.text!)
        
        switch button.tag {
            case 10: // +
                calcLabel.text = performOperation("+", operationFloat: calcValue)
            case 11: // -
                calcLabel.text = performOperation("-", operationFloat: calcValue)
            case 12: // *
                calcLabel.text = performOperation("*", operationFloat: calcValue)
            case 13: // /
                calcLabel.text = performOperation("/", operationFloat: calcValue)
            case 14: // =
                calcLabel.text = performOperation("=", operationFloat: calcValue)
            case 15: // all clear
                calcLabel.text = performOperation("all clear", operationFloat: calcValue)
            default:
                print("nothing entered")
            }
    }
    
    func performOperation(operation:String, operationFloat: Float) -> String{
        
        var floatForCalc: Float = operationFloat
        
        if operation == "all clear" {
            currentNumber = 0
            currentOperation = ""
            return ""
        }
        else if currentOperation == "+"{
            floatForCalc = currentNumber + operationFloat
        }
        else if currentOperation == "-"{
            floatForCalc = currentNumber - operationFloat
        }
        else if currentOperation == "*"{
            floatForCalc = currentNumber * operationFloat
        }
        else if currentOperation == "/"{
            if operationFloat == 0 {
                currentNumber = 0
                currentOperation = ""
                return "Error"
            }
            floatForCalc = currentNumber / operationFloat
        }
        else if currentOperation == "="{
            floatForCalc = currentNumber
        }
        
        
        currentNumber = floatForCalc // now we assign our new waiting number, prepping for next calc.
        currentOperation = operation
        
        if cleanNumber(floatForCalc) {
            return "\(Int(floatForCalc))"
        }
        return "\(floatForCalc)" // this string is then shown at the label on the UIView. 
    }
    
    /* want to check if the floatNumber is a clean number, which means that the
    decimal point contains all zeroes (for example 9.0), so we can represent the
    number as a clean number when displayed on the calcLabel. */
    
    func cleanNumber(floatNumber: Float) -> Bool {
        let intNumber: Int = Int(floatNumber) // takes the Int representation of float
        let newFloat: Float = Float(intNumber) // turns the int back into float so we can calculate.
        if floatNumber == 0.0{
            return true
        }
        if intNumber == 0 {
            return false
        }
        if newFloat % floatNumber == 0 {
            return true
        }
        return false
    }
}

