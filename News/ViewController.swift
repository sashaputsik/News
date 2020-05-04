import UIKit
class ViewController: UIViewController {
        let urlStringArray  = ["http://newsapi.org/v2/everything?q=bitcoin&from=2020-04-04&sortBy=publishedAt&apiKey=69698df82a724ba9b3979013183abb34",
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=69698df82a724ba9b3979013183abb34",
        "http://newsapi.org/v2/everything?q=apple&from=2020-05-03&to=2020-05-03&sortBy=popularity&apiKey=69698df82a724ba9b3979013183abb34"]
    
        var articles: [Articles] = []
        let citeArray = ["Bitcoin articles",
                         "Business headlines",
                         "Apple news"]
        var index = 0
        var citesSelected = [true, false, false]
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var collectionView: UICollectionView!
        let cellId = "cell"
        var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        collectionView.isHidden = true
        let back = UIBarButtonItem()
        back.title = ""
        navigationItem.backBarButtonItem = back
        let view = UIImageView()
        view.image = UIImage(named: "logo2.png")
        navigationItem.titleView = view
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        loadNews(of: 0)
    }
    func loadNews(of index: Int){
        guard let url = URL(string:urlStringArray[index] ) else {return}
           let session = URLSession.shared
           session.dataTask(with: url) { (data, response, error) in
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
               }
           }.resume()
        }
}
