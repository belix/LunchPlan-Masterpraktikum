//
//  ShopTableViewCell.swift
//  LunchPlan
//
//  Created by Felix Belau on 24.11.15.
//  Copyright © 2015 LunchPlan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 0.8)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backGroundWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var backGroundView: UIView!
    
    var time :Int {
        get {
            return self.time
        }
        set {
          //  self.time = newValue
            if newValue > 10{
                self.backGroundWidthConstraint.constant = 280
                self.backGroundView?.backgroundColor = UIColor(netHex: 0xc0392b)
            }
            else if newValue > 8{
                self.backGroundWidthConstraint.constant = 220
                self.backGroundView?.backgroundColor = UIColor(netHex: 0xf39c12)
            }
            else if newValue > 6{
                self.backGroundWidthConstraint.constant = 160
                self.backGroundView?.backgroundColor = UIColor(netHex: 0x9b59b6)
            }
            else if newValue > 4{
                self.backGroundWidthConstraint.constant = 100
                self.backGroundView?.backgroundColor = UIColor(netHex: 0x3498db)
            }
            else{
                self.backGroundWidthConstraint.constant = 40
                self.backGroundView?.backgroundColor = UIColor(netHex: 0x2ecc71)
            }
            self.timeLabel.text = "\(newValue) m"
            self.backGroundView.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
