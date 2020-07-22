import UIKit
class ViewController: UIViewController {
        let urlStringArray  = ["http://newsapi.org/v2/everything?domains=wsj.com&apiKey=69698df82a724ba9b3979013183abb34",
                               "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=69698df82a724ba9b3979013183abb34",
                               "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=69698df82a724ba9b3979013183abb34"]
    
        var articles: [Articles] = []
        let citeArray = ["Wall Street Journal",
                         "Business headlines",
                         "TechCrunch"]
        var index = 0
        var citesSelected = [true, false, false]
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var loadActivityIndecator: UIActivityIndicatorView!
    
        let cellId = "cell"
        var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        collectionView.isHidden = true
        loadActivityIndecator.isHidden = false
        loadActivityIndecator.startAnimating()
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        addedBarItems()
        delegates()
        loadNews(of: 0)
    }
    func loadNews(of index: Int){
        guard let url = URL(string:urlStringArray[index] ) else {return}
           let session = URLSession.shared
           session.dataTask(with: url) {[weak self] (data, response, error) in
            guard let self = self else{return}
               guard let data = data, error == nil else{print(error!);return}
                   do{
                       let newsArrays = try JSONDecoder().decode(News.self, from: data)
                       self.articles = newsArrays.articles
                   }
                   catch let error{
                       print(error)
                   }
               DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.collectionView.isHidden = false
                self.loadActivityIndecator.isHidden = true
                self.loadActivityIndecator.stopAnimating()
               }
           }.resume()
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
}
