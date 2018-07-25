//
//  MyCell.swift
//  01-AppStoreAnimation
//
//  Created by ZhangJi on 2018/7/25.
//  Copyright © 2018 ZhangJi. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    typealias lewisCloser = () -> ()

    var containView: UIView!
    var topImageView: UIImageView!
    var titleLabel: UILabel!
    var describeLabel: UILabel!
    var cancelButton: UIButton!
    
    var closeAcctionBlock: lewisCloser?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addSubview() {
        self.containView = UIView(frame: CGRect(x: 20, y: 20, width: ScreenWidth - 40, height: 375))
        self.containView.layer.cornerRadius = 10
        self.containView.clipsToBounds = true
        
        self.topImageView = UIImageView(frame: CGRect(x: -20, y: -20, width: ScreenWidth, height: ScreenWidth * 491 / 375))
        
        self.cancelButton = UIButton(frame: CGRect(x: ScreenWidth - 40, y: 20, width: 30, height: 30))
        self.cancelButton.setImage(#imageLiteral(resourceName: "关闭"), for: .normal)
        self.cancelButton.addTarget(self, action: #selector(closeAcction), for: .touchUpInside)
        
        self.contentView.addSubview(self.containView)
        self.containView.addSubview(topImageView)
        self.containView.addSubview(cancelButton)
    }
    
    @objc func closeAcction() {
        if self.closeAcctionBlock != nil {
            self.closeAcctionBlock!()
        }
    }

}
