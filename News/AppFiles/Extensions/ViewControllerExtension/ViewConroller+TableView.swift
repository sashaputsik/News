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
        if let date = new.publishedAt{
        let date1 = date.dropLast(10)
        cell.dateTextLabel.text = "\(date1)"
        }
        if let urlToImage = new.urlToImage{
            if let data = try? Data(contentsOf:urlToImage ){
                let image = UIImage(data: data)
                cell.newImageView.image = image
        }
        }
        cell.newImageView.layer.cornerRadius = 10
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else {return}
        if  let title = articles[indexPath.row].title,
            let urlToImage = articles[indexPath.row].urlToImage,
            let content = articles[indexPath.row].content,
            let url = articles[indexPath.row].url,
            let author = articles[indexPath.row].author {
                vc.titleText = title
                vc.imageUrl = "\(urlToImage)"
                vc.contentText = content
                vc.url = "\(url)"
                vc.author = author
        }
        if let source = articles[indexPath.row].source{
            if let sourceName = source.name{
                vc.source = sourceName
            }
        }
        navigationController?.pushViewController(vc,
                                                 animated: true)
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
        }
        else{
            cell.newsLabel.font = UIFont(name: "Baskerville", size: 15)
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
        tableView.isHidden = true
        loadActivityIndecator.isHidden = false
        loadActivityIndecator.startAnimating()
        for i in 0..<citesSelected.count{
            citesSelected[i] = false
            citesSelected[indexPath.row] = true
            collectionView.reloadData()
        }
        loadNews(of: indexPath.row)
    }
    
}
