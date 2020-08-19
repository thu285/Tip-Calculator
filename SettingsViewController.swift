//
//  SettingsViewController.swift
//  tip
//
//  Created by Do, Thu on 8/18/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "index") != nil
        {
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "index")
        }
        setDefaultTip(self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func setDefaultTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        let index = tipControl.selectedSegmentIndex
        if (index == 3){
            getCustomTip(self)
        }
        defaults.set(index, forKey: "index")
        defaults.synchronize()
    }
    func getCustomTip(_ sender: Any){
        let customTipTextField = UITextField(frame: CGRect(x:280,y:350,width:60,height:40))
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "percent") != nil
        {
            let percent = defaults.double(forKey: "percent") * 100
            print(percent)
            let percentText = String(format: "%.1f", percent)
            customTipTextField.text = percentText
        }
        //customTipTextField.placeholder = "e.g. 18"
        customTipTextField.keyboardType = UIKeyboardType.decimalPad
        customTipTextField.layer.borderWidth = 1
        let myColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        customTipTextField.layer.borderColor = myColor.cgColor
        customTipTextField.layer.cornerRadius = 5
        customTipTextField.clipsToBounds = true
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
        let customTip = Double(textField.text!) ?? 0
        let customPercent = customTip/100.0
        let defaults = UserDefaults.standard
        defaults.set(customPercent, forKey: "percent")
        defaults.synchronize()
        // always return true so that changes propagate
        return true
    }
}
