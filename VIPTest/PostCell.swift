//
//  PostCell.swift
//  VIPTest
//
//  Created by AnkurPipaliya on 13/07/23.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblBody: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
