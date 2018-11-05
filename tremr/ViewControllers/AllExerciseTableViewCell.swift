//
//  AllExerciseTableViewCell.swift
//  tremr
//
//  Created by Colin Chan on 11/4/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class AllExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerNameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var delButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
