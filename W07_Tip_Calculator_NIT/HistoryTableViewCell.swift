//
//  HistoryTableViewCell.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Cntt16 on 5/27/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBillAmount: UILabel!
    @IBOutlet weak var lblTipAmount: UILabel!
    @IBOutlet weak var lblTipResult: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
