//
//  Name of file: DailyExerciseTableViewCell.swift
//  Programmers: Colin Chan
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-26: created file
// Known Bugs:

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
