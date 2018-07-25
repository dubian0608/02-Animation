
//
//  ViewController.swift
//  01-AppStoreAnimation
//
//  Created by ZhangJi on 2018/7/24.
//  Copyright © 2018 ZhangJi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animateTableView: UITableView!
    
    var images = [#imageLiteral(resourceName: "fireman"), #imageLiteral(resourceName: "meinv1"), #imageLiteral(resourceName: "fengjing2")]
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    var isStatusBarHidden = false {
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.containView.frame = CGRect(x: 20, y: 20, width: ScreenWidth - 40, height: 375)
        cell.topImageView.image = images[indexPath.row]
//        cell.titleLabel.text = "冠军之战，东部豪门对阵西部黑马"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyCell
        
        UIView.animate(withDuration: 0.3) {
            cell.containView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyCell
        
        UIView.animate(withDuration: 0.3) {
            cell.containView.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyCell
        
        let transformFrame = cell.containView.convert(cell.containView.bounds, to: self.view)
        cell.containView.frame = transformFrame
        
        self.view.addSubview(cell.containView)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
            cell.containView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
            cell.containView.layer.cornerRadius = 0

            cell.topImageView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth * 491 / 375)
            
            cell.cancelButton.isHidden = false
            
            self.isStatusBarHidden = true
        }) { (finished) in
//            self.view.addSubview(cell.containView)
        }
        
        cell.closeAcctionBlock = { () -> () in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .allowAnimatedContent, animations: {
                cell.containView.frame = transformFrame
                cell.containView.layer.cornerRadius = 10
                
                cell.topImageView.frame = CGRect(x: -20, y: -20, width: ScreenWidth, height: ScreenWidth * 491 / 375)
                
                cell.cancelButton.isHidden = true
                
                self.isStatusBarHidden = false
            }) { (finished) in
                cell.containView.frame = CGRect(x: 20, y: 20, width: ScreenWidth - 40, height: 375)
                cell.contentView.addSubview(cell.containView)
            }
        }
    }
}
