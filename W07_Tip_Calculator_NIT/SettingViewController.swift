//
//  SettingViewController.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Tran Van Tin on 5/23/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var lblTitleTopConstraint: NSLayoutConstraint!
    @IBOutlet var pickerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var btnSaveTopConstraint: NSLayoutConstraint!
    @IBOutlet var btnSaveBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let tipAmount = [5, 10, 15]
    var temp: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        pickerView.dataSource = self
        pickerView.delegate = self
        temp = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipAmount.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(tipAmount[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temp = tipAmount[row]
    }
    
    @IBAction func btnSave(_ sender: Any) {
        UserDefaults.standard.set(temp, forKey: "tipKey")
        self.navigationController?.popViewController(animated: true)
    }
}
