//
//  DailyExerciseTableViewCell.swift
//  tremr
//
//  Created by Colin Chan on 11/4/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class DailyExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var exerNameLabel: UILabel!
    @IBOutlet weak var exerUnitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
