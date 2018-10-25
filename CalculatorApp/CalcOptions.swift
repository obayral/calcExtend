//
//  CalcOptions.swift
//  CalculatorApp
//
//  Created by Oguz Bayral on 18.10.2018.
//  Copyright © 2018 CentennialCollege. All rights reserved.
//

import UIKit

class CalcOptions: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var background: UIPickerView!
    
    var selectedBackgroundColor:String = ""
    
    private var firstView: ViewController!
    
    
    let colors = ["Default","Red","Yellow","Green","Blue","Orange","Purple","White"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedIndex = background.selectedRow(inComponent: 0)
        selectedBackgroundColor = colors[selectedIndex]
        
        firstView = storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            selectedBackgroundColor = colors[row] as String
        }
        
    }
    @IBAction func saveOps(_ sender: UIButton) {
        print(selectedBackgroundColor)
        if selectedBackgroundColor == "Red"{
            //print("girdi")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let firstView = segue.destination as? ViewController else{return}
        
        if selectedBackgroundColor == "Default"{
            firstView.backgroundColor =  ""
        }
        if selectedBackgroundColor == "Red"{
            firstView.backgroundColor =  "Red"
        }
        if selectedBackgroundColor == "Yellow"{
            firstView.backgroundColor =  "Yellow"
        }
        if selectedBackgroundColor == "Green"{
            firstView.backgroundColor =  "Green"
        }
        if selectedBackgroundColor == "Blue"{
            firstView.backgroundColor =  "Blue"
        }
        if selectedBackgroundColor == "Orange"{
            firstView.backgroundColor =  "Orange"
        }
        if selectedBackgroundColor == "Purple"{
            firstView.backgroundColor =  "Purple"
        }
        if selectedBackgroundColor == "White"{
            firstView.backgroundColor =  "White"
        }
        
    }
}
