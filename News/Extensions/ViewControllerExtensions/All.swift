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
        loadActivityIndicator.layer.shadowOpacity = Float(UIButton.Appearance().shadowOpacity)
        loadActivityIndicator.layer.shadowOffset = UIButton.Appearance().shadowOffset
        oneNewImageView.layer.cornerRadius = UIButton.Appearance().cornerRadius
        
        oneNewView.layer.shadowOpacity = Float(UIButton.Appearance().shadowOpacity)
        oneNewView.layer.shadowOffset = UIButton.Appearance().shadowOffset
        seeMoreButton.layer.shadowOpacity = Float(UIButton.Appearance().shadowOpacity)
        seeMoreButton.layer.shadowOffset = UIButton.Appearance().shadowOffset
    }
}


extension UIButton{
   public struct Appearance {
        let cornerRadius: CGFloat = 10
        let shadowOpacity: Float = 0.5
        let shadowOffset = CGSize(width: 2, height: 2)
    }
}
