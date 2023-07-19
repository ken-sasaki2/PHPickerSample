//
//  TableViewCell.swift
//  PHPickerSample
//
//  Created by sasaki.ken on 2023/07/19.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
