//
//  ViewController.swift
//
//
//  Created by Jason Cashdollar on 10/6/15.
//  Copyright © 2015 Jason Cashdollar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // landscape vars
    @IBOutlet weak var landscapeBillAmount:
        UILabel!
    @IBOutlet weak var landscapeTipAmount: UILabel!
    @IBOutlet weak var landscapeTotal: UILabel!
    @IBOutlet var landscapeEquation: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        //  hide landscapeEquation using either hidden or alpha here
        for view in landscapeEquation {
            view.alpha = UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 1.0 : 0.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

        // pre-fill initial landscape values
        landscapeBillAmount.text = "$0.00"
        landscapeTipAmount.text = "$0.00"
        landscapeTotal.text = "$0.00"
        
        // assign values to landscape values
        landscapeBillAmount.text = String(format: "$%.2f", billAmount)
        landscapeTipAmount.text = String(format: "$%.2f", tip)
        landscapeTotal.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // detect when orientation changes
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        // Note: landscapeEquation probably doesn't need to be an array, could just be a reference a view that has all the others as children.
        
        // crossfade with rotation tips
        // h/t to tj for help
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            for view in self.landscapeEquation {
                view.alpha = size.width < size.height ? 0.0 : 1.0
            }
            }, completion: nil)
    }
    
}

