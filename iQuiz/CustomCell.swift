//
//  CustomCell.swift
//  iQuiz
//
//  Created by Maxwell London on 5/7/22.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet var cellView: UIView!
    
    @IBOutlet var cellIMG: UIImageView!
    
    @IBOutlet var cellLabel: UILabel!
    
    @IBOutlet var cellSubLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
