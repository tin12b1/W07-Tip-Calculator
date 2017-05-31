//
//  HistoryTableViewController.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Cntt16 on 5/27/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    var historyList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHistoryList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        let history = historyList[indexPath.row]
        cell.lblDate.text = history.value(forKeyPath: "date") as? String
        if let billAmount = history.value(forKeyPath: "billAmount") {
            cell.lblBillAmount.text = "Bill Amount: \(billAmount)"
        }
        if let tipAmount = history.value(forKeyPath: "tipAmount") {
            cell.lblTipAmount.text =  "Tip Amount: \(tipAmount)"
        }
        if let tipResult = history.value(forKeyPath: "tipResult") {
            cell.lblTipResult.text = "Tip Result: \(tipResult)"
        }
        if let totalAmount = history.value(forKeyPath: "total") {
            cell.lblTotalAmount.text = "Total Amount: \(totalAmount)"
        }
        return cell
    }
    
    // Get history list from core data
    func getHistoryList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for result in results{
                historyList.append(result as! NSManagedObject)
            }
        } catch {
            print("Error")
        }
    }
}
