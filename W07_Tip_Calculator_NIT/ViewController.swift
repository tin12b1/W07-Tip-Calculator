//
//  ViewController.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Cntt16 on 5/19/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    // Constraints
    @IBOutlet weak var billTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipResultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCalculateRightConstraint: NSLayoutConstraint!
    // Text field and Label
    @IBOutlet var txtBillAmount: UITextField!
    @IBOutlet var lblTipAmount: UILabel!
    @IBOutlet var lblTipResult: UILabel!
    @IBOutlet var lblTotal: UILabel!
    // Tip Amount variable
    var tipAmount: Int?
    var keyboardIsShow = false

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
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // Get current date
    func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: currentDate)
        return date
    }
    
    // Process when click button Calculate
    @IBAction func btnCalculateClick(_ sender: Any) {
        if txtBillAmount.text!.isEmpty {
            // Missing input (Bill Amount)
            let alert = UIAlertController(title: "Error", message: "You must input Bill Amount!", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
        else {
            let result = calculate()
            lblTipResult.text = "\(result[0])"
            lblTipResult.isHidden = false
            lblTotal.text = "\(result[1])"
            lblTotal.isHidden = false
            view.endEditing(true)
            let date = getCurrentDate()
            // Save history use core data
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "History", in: managedContext)!
            let history = NSManagedObject(entity: entity, insertInto: managedContext)
            history.setValue(date, forKeyPath: "date")
            history.setValue(result[0], forKeyPath: "tipResult")
            history.setValue(result[1], forKeyPath: "total")
            history.setValue(result[2], forKeyPath: "billAmount")
            history.setValue(result[3], forKeyPath: "tipAmount")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    // Calculate function
    func calculate() -> [Double] {
        let billAmount: Double = Double(txtBillAmount.text!)!
        let tipResult = billAmount * Double(tipAmount!) / 100
        let totalAmount = billAmount + tipResult
        return [tipResult, totalAmount, billAmount, Double(tipAmount!)]
    }
    
    // Check input value
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

    // Process when user rotate device
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
            billTopConstraint.constant = 40
            tipTopConstraint.constant = 30
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
    func keyboardWillShow(notification:NSNotification) {
        if !keyboardIsShow {
            adjustingHeight(show: true, notification: notification)
            keyboardIsShow = true
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        if keyboardIsShow {
            adjustingHeight(show: false, notification: notification)
            keyboardIsShow = false
        }
        
    }
    
    // Change button Calculate constraint value
    func adjustingHeight(show:Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            if show {
                self.resultTopConstraint.constant += 20
                self.billTopConstraint.constant -= 10
                self.tipTopConstraint.constant -= 20
            }
            else {
                self.resultTopConstraint.constant -= 20
                self.billTopConstraint.constant += 10
                self.tipTopConstraint.constant += 20
            }
        })
    }
    
    @IBAction func userTappedBackground(_ sender: Any) {
        view.endEditing(true)
    }
}

