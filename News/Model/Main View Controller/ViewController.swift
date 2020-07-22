import UIKit
class ViewController: UIViewController {
    var index = 0
    var citesSelected = [true, false, false]
    let cellId = "cell"
    @IBOutlet weak var oneNewView: UIView!
    @IBOutlet weak var oneNewImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadActivityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var oneNewNameLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        seeMoreButton.addTarget(self, action: #selector(seeMore), for: .touchUpInside)
        tableView.isHidden = true
        collectionView.isHidden = true
        loadActivityIndecator.isHidden = false
        loadActivityIndecator.startAnimating()
        collectionView.allowsMultipleSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        addedBarItems()
        frameAndLayer()
        delegates()
        getCurrentDate()
        loadNews(of: 0)
    }
    @objc func seeMore(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AllNews") as? AllNewsViewController else{return}
        vc.modalPresentationStyle = .automatic
        show(vc, sender: nil)
    }
}


