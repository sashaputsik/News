import UIKit
class ViewController: UIViewController {
    var index = 0
    var randomValue = 0
    var citesSelected = [true, false, false]
    let cellId = "cell"
    @IBOutlet weak var oneNewView: UIView!
    @IBOutlet weak var oneNewImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadActivityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var oneNewTitleLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var latestNewsLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        seeMoreButton.addTarget(self, action: #selector(seeMore), for: .touchUpInside)
        loadActivityIndecator.startAnimating()
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOneViewNew))
        oneNewView.addGestureRecognizer(tap)
        isHiddenView(of: true)
        addedBarItems()
        frameAndLayer()
        delegates()
        Parse().loadNews(of: 0) {
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
                }
            }
    }
    @objc func tapOneViewNew(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else{return}
        let news = articles[randomValue]
        vc.author = news.author
        vc.titleText = news.title
        vc.content = news.content
        vc.url = "\(news.url)"
        vc.urlToImage = "\(news.urlToImage)"
        vc.sourceName = news.name
        showDetailViewController(vc, sender: nil)
    }
    @objc func seeMore(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AllNews") as? AllNewsTableViewController else{return}
        navigationController?.pushViewController(vc, animated: true)
    }
}


