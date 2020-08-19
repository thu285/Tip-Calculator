//
//  ViewController.swift
//  tip
//
//  Created by Do, Thu on 8/18/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var percent: Double!
    var index: Int!
    var customTipTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var shareTwo: UILabel!
    @IBOutlet weak var shareThree: UILabel!
    @IBOutlet weak var shareFour: UILabel!
    let tipPercents = [0.15, 0.18, 0.2]
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "index") != nil
        {
            index = defaults.integer(forKey: "index")
            tipControl.selectedSegmentIndex = index
            if (index < 3){
                percent = tipPercents[index]
                calculateTipHelper(percent: percent)
            }
            else {
                let percent = defaults.double(forKey: "percent")
                calculateTipHelper(percent: percent)
                getCustomTip(self)
            }
        }
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        billAmountTextField.resignFirstResponder()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        index = tipControl.selectedSegmentIndex
        if (index < 3){
            percent = tipPercents[index]
            calculateTipHelper(percent: percent)
        } else {
            getCustomTip(self);
        }
    }
    func getCustomTip(_ sender: Any){
        customTipTextField = UITextField(frame: CGRect(x:280,y:350,width:60,height:40))
        customTipTextField.keyboardType = UIKeyboardType.decimalPad
        customTipTextField.layer.borderWidth = 1
        let myColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        customTipTextField.layer.borderColor = myColor.cgColor
        customTipTextField.layer.cornerRadius = 5
        customTipTextField.clipsToBounds = true
        customTipTextField.textAlignment = .right
        let percentSymbol = UILabel(frame:CGRect(x:345, y: 350, width: 20, height: 40))
        percentSymbol.text = "%"
        let insertText = UILabel(frame:CGRect(x: 15, y: 350, width: 300, height: 30))
        insertText.text = "Insert your custom tip percent"
        view.addSubview(customTipTextField)
        view.addSubview(percentSymbol)
        view.addSubview(insertText)
        customTipTextField.addTarget(self, action: #selector(textField), for: .editingChanged)
    }
    @objc func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        let customTip = Double(textField.text!) ?? 0
        percent = customTip / 100.0
        calculateTipHelper(percent: percent)

        // always return true so that changes propagate
        return true
    }
    func calculateTipHelper(percent: Double){
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * percent
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        let two = total/2.0
        let three = total/3.0
        let four = total/4.0
        shareTwo.text = String(format: "$%.2f", two)
        shareThree.text = String(format: "$%.2f", three)
        shareFour.text = String(format: "$%.2f", four)
    }
}

