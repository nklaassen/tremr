//
//  Name of file: MedicationTableViewCell.swift
//  Programmers: Jason Fevang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
// Known Bugs:

import UIKit

class notificationTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bellButton: NotificationToggleButton!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
