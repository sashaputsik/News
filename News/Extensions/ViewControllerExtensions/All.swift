import Foundation
import UIKit

extension ViewController{
    func isHiddenView(of booler: Bool){
        latestNewsLabel.isHidden = booler
        oneNewImageView.isHidden = booler
        seeMoreButton.isHidden = booler
        oneNewTitleLabel.isHidden = booler
        tableView.isHidden = booler
        collectionView.isHidden = booler
        loadActivityIndecator.isHidden = !booler
    }
    func delegates(){
       collectionView.dataSource = self
       collectionView.delegate = self
       tableView.delegate = self
       tableView.dataSource = self
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
        loadActivityIndecator.layer.shadowOpacity = 0.5
        loadActivityIndecator.layer.shadowOffset = CGSize(width: 1, height: 1)
        oneNewImageView.layer.cornerRadius = 10
        oneNewView.layer.shadowOpacity = 0.8
        oneNewView.layer.shadowOffset = CGSize(width: 1, height: 2)
        seeMoreButton.layer.shadowOpacity = 0.5
        seeMoreButton.layer.shadowOffset = CGSize(width: 1, height: 0)
    }
}
