import Foundation
import UIKit
//MARK: TABLE VIEW DELEGATE
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
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
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else {return}
        let news = articles[indexPath.row]
       
        vc.titleText = news.title
        vc.urlToImage = "\(news.urlToImage)"
        vc.content = news.content
        vc.url = "\(news.url)"
        vc.author = news.author
        vc.sourceName = news.name
        showDetailViewController(vc, sender: nil)
        }
    }
    
//MARK: COLLECTION VIEW DELEGATE
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return NewsResource().citeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! CollectionViewCell
        cell.newsLabel.text = NewsResource().citeArray[indexPath.row]
        cell.layer.cornerRadius = 5
        if citesSelected[indexPath.row]{
            cell.newsLabel.font = UIFont(name: "Baskerville-Bold", size: 17)
            cell.newsLabel.layer.shadowOpacity = 0.3
            cell.newsLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
        else{
            cell.newsLabel.font = UIFont(name: "Baskerville", size: 15)
            cell.newsLabel.layer.shadowOpacity = 0.0
            cell.newsLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
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
        isHiddenView(of: true)
        collectionView.isHidden = false
        loadActivityIndecator.startAnimating()
        for i in 0..<citesSelected.count{
            citesSelected[i] = false
            citesSelected[indexPath.row] = true
            collectionView.reloadData()
        }
        articles.removeAll()
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
        try? FileManager.default.removeItem(atPath: path)
        Parse().loadNews(of: indexPath.row) {
            self.randomValue = Int.random(in: 0..<articles.count)
            let oneNew = articles[self.randomValue]
            guard let url = URL(string: oneNew.urlToImage) else{return}
            guard let data = try? Data(contentsOf: url) else{return}
            DispatchQueue.main.async {
                self.oneNewImageView.image = UIImage(data: data)
                self.oneNewTitleLabel.text = oneNew.title
                self.tableView.reloadData()
                self.isHiddenView(of: false)
                self.loadActivityIndecator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
}
