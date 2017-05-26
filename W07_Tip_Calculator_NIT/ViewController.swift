//
//  ViewController.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Cntt16 on 5/19/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Constraints
    @IBOutlet weak var billTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipResultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateRightConstraint: NSLayoutConstraint!
    //
    @IBOutlet var txtBillAmount: UITextField!
    @IBOutlet var lblTipAmount: UILabel!
    @IBOutlet var lblTipResult: UILabel!
    @IBOutlet var lblTotal: UILabel!
    //
    var tipAmount: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTipResult.isHidden = true
        lblTotal.isHidden = true
        txtBillAmount.keyboardType = UIKeyboardType.decimalPad
        if let temp = UserDefaults.standard.object(forKey: "tipKey") as? Int {
            lblTipAmount.text = String(temp)
            tipAmount = temp
        }else {
            lblTipAmount.text = "5"
            tipAmount = 5
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let temp = UserDefaults.standard.object(forKey: "tipKey") as? Int {
            lblTipAmount.text = String(temp)
            tipAmount = temp
        }
        txtBillAmount.text?.removeAll()
        lblTipResult.isHidden = true
        lblTotal.isHidden = true
    }
    @IBAction func btnCalculateClick(_ sender: Any) {
        if txtBillAmount.text!.isEmpty {
            // Thong bao nhap thieu thong tin
            let alert = UIAlertController(title: "Error", message: "You must input Bill Amount!", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
        else {
            let billAmount: Double = Double(txtBillAmount.text!)!
            let tipResult = billAmount * Double(tipAmount!) / 100
            lblTipResult.text = "\(tipResult)"
            lblTipResult.isHidden = false
            let totalAmount = billAmount + tipResult
            lblTotal.text = "\(totalAmount)"
            lblTotal.isHidden = false
            view.endEditing(true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = txtBillAmount.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                if string == "-" {
                    if (txtBillAmount.text!.isEmpty == true){
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
            billTopConstraint.constant = 40
            tipTopConstraint.constant = 30
            numberTopConstraint.constant = 30
            btnCalculateTopConstraint.constant = 30
            btnCalculateLeftConstraint.constant = 80
            btnCalculateRightConstraint.constant = 80
            resultTopConstraint.constant = 30
            tipResultTopConstraint.constant = 30
            totalTopConstraint.constant = 30
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            billTopConstraint.constant = 10
            tipTopConstraint.constant = 10
            numberTopConstraint.constant = 10
            btnCalculateTopConstraint.constant = 10
            btnCalculateLeftConstraint.constant = 222
            btnCalculateRightConstraint.constant = 222
            resultTopConstraint.constant = 10
            tipResultTopConstraint.constant = 10
            totalTopConstraint.constant = 10
            text="LandscapeLeft"
        case .landscapeRight:
            billTopConstraint.constant = 10
            tipTopConstraint.constant = 10
            numberTopConstraint.constant = 10
            btnCalculateTopConstraint.constant = 10
            btnCalculateLeftConstraint.constant = 222
            btnCalculateRightConstraint.constant = 222
            resultTopConstraint.constant = 10
            tipResultTopConstraint.constant = 10
            totalTopConstraint.constant = 10
            text="LandscapeRight"
        default:
            text="Another"
        }
        NSLog("You have moved: \(text)")        
    }
    
    
}

