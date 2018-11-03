//
//  DailyMedicationTableViewCell.swift
//  tremr
//
//  Created by Jason Fevang on 10/31/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class DailyMedicationTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var medDosageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
