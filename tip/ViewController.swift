//
//  ViewController.swift
//  tip
//
//  Created by Do, Thu on 8/18/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get the bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercents = [0.15, 0.18, 0.2]
        
        // Calculate tip and total
        let tip = bill * tipPercents[tipControl.selectedSegmentIndex];
        let total = bill + tip
        
        // Update tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

