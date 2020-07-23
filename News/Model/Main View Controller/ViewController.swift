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
        loadNews(of: 0)
    }
    @objc func tapOneViewNew(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else{return}
        if let title = articles[randomValue].title,
            let urlToImage = articles[randomValue].urlToImage,
            let content = articles[randomValue].content,
            let url = articles[randomValue].url,
            let author = articles[randomValue].author {
            vc.author = author
            vc.title = title
            vc.content = content
            vc.url = "\(url)"
            vc.urlToImage = "\(urlToImage)"
        }
        if let source = articles[randomValue].source{
            guard let sourceName = source.name else{return}
            vc.sourceName = sourceName
        }
        showDetailViewController(vc, sender: nil)
    }
    @objc func seeMore(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AllNews") as? AllNewsTableViewController else{return}
        navigationController?.pushViewController(vc, animated: true)
    }
}


