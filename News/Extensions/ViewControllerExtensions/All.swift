import Foundation
import UIKit

extension ViewController{
    
    func setView(isHidden: Bool){
        latestNewsLabel.isHidden = isHidden
        oneNewImageView.isHidden = isHidden
        seeMoreButton.isHidden = isHidden
        oneNewTitleLabel.isHidden = isHidden
        tableView.isHidden = isHidden
        collectionView.isHidden = isHidden
        loadActivityIndecator.isHidden = !isHidden
    }
    
    func addedBarItems(){
       let back = UIBarButtonItem()
       back.title = ""
       navigationItem.backBarButtonItem = back
       let view = UIImageView()
       view.image = UIImage(named: "logo.png")
       navigationItem.titleView = view
    }
    
    func frameAndLayer(){
        loadActivityIndecator.layer.shadowOpacity = Float(UIButton.Appearence().shadowOpacity)
        loadActivityIndecator.layer.shadowOffset = UIButton.Appearence().shadowOffset
        oneNewImageView.layer.cornerRadius = 10
        oneNewView.layer.shadowOpacity = Float(UIButton.Appearence().shadowOpacity)
        oneNewView.layer.shadowOffset = UIButton.Appearence().shadowOffset
        seeMoreButton.layer.shadowOpacity = Float(UIButton.Appearence().shadowOpacity)
        seeMoreButton.layer.shadowOffset = UIButton.Appearence().shadowOffset
    }
}
