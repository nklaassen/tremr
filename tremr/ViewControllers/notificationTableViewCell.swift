//
//  Name of file: notificationTableViewCell.swift
//  Programmers: Jason Fevang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-29: Created file and initial functions
//          2018-11-16: Created button and label
// Known Bugs: N/A

import UIKit

//Class for the table cells on the notification view page 
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
