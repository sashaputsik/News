import Foundation
import UIKit

//MARK: TableViewDelegateDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id,
                                                       for:indexPath) as? TableViewCell else{ return UITableViewCell() }
        let new = articles[indexPath.row]
        cell.titleTextLabel.text = new.title
        let date = new.publishedAt
        let date1 = date.dropLast(10)
        cell.dateTextLabel.text = "\(date1)"
        guard let url = URL(string: new.urlToImage) else{return UITableViewCell()}
        if let data = try? Data(contentsOf:url ){
            let image = UIImage(data: data)
            cell.newImageView.image = image
        }
        cell.newImageView.layer.cornerRadius = 15
        return cell
    }
}


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OneNewViewController") as? OneNewViewController else {return}
        let news = articles[indexPath.row]
        vc.titleText = news.title
        vc.urlToImage = "\(news.urlToImage)"
        vc.content = news.content
        vc.url = "\(news.url)"
        vc.author = news.author
        vc.sourceName = news.name
        showDetailViewController(vc,
                                 sender: nil)
    }
}
    
//MARK: CollectionViewDelegate
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return NewsResource().citeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.id,
                                                           for: indexPath) as? CollectionViewCell else{return UICollectionViewCell()}
        cell.newsLabel.text = NewsResource().citeArray[indexPath.row]
        cell.layer.cornerRadius = CGFloat(UITableViewCell.Appearence().cornerRadius)
        if citesSelected[indexPath.row]{
            cell.newsLabel.font = UITableViewCell.Appearence().font
            cell.newsLabel.layer.shadowOpacity = Float(UITableViewCell.Appearence().shadowOpacity)
            cell.newsLabel.layer.shadowOffset = UITableViewCell.Appearence().shadowOffset
        }
        else{
            cell.newsLabel.font = UITableViewCell.Appearence().fontBold
            cell.newsLabel.layer.shadowOpacity = Float(UITableViewCell.Appearence().shadowOpacity)
            cell.newsLabel.layer.shadowOffset = UITableViewCell.Appearence().shadowOffset
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 186, height: 32)
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        setView(isHidden: true)
        collectionView.isHidden = false
        loadActivityIndicator.startAnimating()
        for i in 0..<citesSelected.count{
            citesSelected[i] = false
            citesSelected[indexPath.row] = true
            collectionView.reloadData()
        }
        articles.removeAll()
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
                                                       .userDomainMask,
                                                       true)[0]+"/data.json"
        try? FileManager.default.removeItem(atPath: path)
        Parse().loadNews(of: indexPath.row, needFunc: didSelectCollectionViewCell()) {
            self.randomValue = Int.random(in: 0..<articles.count)
           print("work")
        }
    }
}


//MARK: UICollectionViewCell
extension UICollectionViewCell{
   public static var id: String{
        return "cell"
   }
}

 private extension UITableViewCell{
    struct Appearence {
        let cornerRadius = 5
        let font = UIFont(name: "Baskerville",
                          size: 15)
        let fontBold = UIFont(name: "Baskerville-Bold",
                              size: 17)
        let shadowOpacity = 0.3
        let shadowOffset = CGSize(width: 1, height: 1)
    }
}

//MARK: UITableViewCell
extension UITableViewCell{
    public static var id: String{
        return "cell"
    }
}

