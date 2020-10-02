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
        loadActivityIndicator.isHidden = !isHidden
    }
    
    
    
    func frameAndLayer(){
        loadActivityIndicator.layer.shadowOpacity = Float(UIButton.Appearence().shadowOpacity)
        loadActivityIndicator.layer.shadowOffset = UIButton.Appearence().shadowOffset
        oneNewImageView.layer.cornerRadius = 10
        oneNewView.layer.shadowOpacity = Float(UIButton.Appearence().shadowOpacity)
        oneNewView.layer.shadowOffset = UIButton.Appearence().shadowOffset
        seeMoreButton.layer.shadowOpacity = Float(UIButton.Appearence().shadowOpacity)
        seeMoreButton.layer.shadowOffset = UIButton.Appearence().shadowOffset
    }
}


extension UIButton{
    struct Appearence {
        let shadowOpacity = 0.5
        let shadowOffset = CGSize(width: 2, height: 2)
    }
}
