//
//  RateInfoTableViewCell.swift
//  Rates Swift
//
//  Created by Artashes Noknok on 7/16/21.
//

import UIKit

class RateInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fromValueLabel: UILabel!
    @IBOutlet weak var toValueLabel: UILabel!
    @IBOutlet weak var currMnemFromLabel: UILabel!
    @IBOutlet weak var currMnemToLabel: UILabel!
    @IBOutlet weak var basicLabel: UILabel!
    @IBOutlet weak var buyValeuLabel: UILabel!
    @IBOutlet weak var saleValueLabel: UILabel!
    @IBOutlet weak var deltaBuyLabel: UILabel!
    @IBOutlet weak var deltaSaleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
