//
//  AllMedicationTableViewCell.swift
//  tremr
//
//  Created by Jason Fevang on 2018-11-03.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class AllMedicationTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var dosageLabel: UILabel!
    @IBOutlet weak var delButton: UIButton!
    
    
    //MARK: UITableViewCell override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: Actions
    
    


}
