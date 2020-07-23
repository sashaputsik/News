import Foundation
import UIKit

extension ViewController{
    func isHiddenView(of booler: Bool){
        oneNewImageView.isHidden = booler
        currentDateLabel.isHidden = booler
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
    func loadNews(of index: Int){
        guard let url = URL(string:NewsResource().urlStringArray[index] ) else {return}
        print(url)
        let session = URLSession.shared
        session.dataTask(with: url) {[weak self] (data, response, error) in
            guard let self = self else{return}
            guard let data = data else{return}
                  do{
                      let newsArrays = try JSONDecoder().decode(News.self, from: data)
                      articles = newsArrays.articles
                    print(articles)
                    self.randomValue = Int.random(in: 0...articles.count)
                  }
                  catch let error{
                      print(error)
                  }
            guard let nameOfNew = articles[self.randomValue].title else{return}
            guard let urlString = articles[self.randomValue].urlToImage else{return}
            guard let dataImage = try? Data(contentsOf: urlString) else{return}
              DispatchQueue.main.async {
                self.oneNewTitleLabel.text = nameOfNew
                self.oneNewImageView.image = UIImage(data: dataImage)
                self.tableView.reloadData()
                self.isHiddenView(of: false)
                self.loadActivityIndecator.stopAnimating()
                print(articles)
              }
          }.resume()
    }
    func frameAndLayer(){
        oneNewImageView.layer.cornerRadius = 10
        oneNewView.layer.shadowOpacity = 0.4
        oneNewView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
