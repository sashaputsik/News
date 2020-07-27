import UIKit
import SafariServices
class OneNewViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var loadActivityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var sourceTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var safariButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    var titleText = ""
    var content = ""
    var urlToImage = ""
    var url = ""
    var sourceName = ""
    var author = ""
    override func viewWillAppear(_ animated: Bool) {
        loadActivityIndicator.startAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        frameAndLayer()
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        safariButton.addTarget(self, action: #selector(safari), for: .touchUpInside)
        DispatchQueue.main.async {
            self.contentTextView.text = self.content
            self.titleTextLabel.text = self.titleText
            self.authorTextLabel.text = self.author
            self.sourceTextLabel.text = self.sourceName
            guard let urlImage = URL(string: self.urlToImage) else{return}
            if let dataImage = try? Data(contentsOf: urlImage){
                self.newImageView.image = UIImage(data: dataImage)
                self.loadActivityIndicator.isHidden = true
                self.loadActivityIndicator.stopAnimating()
            }
        }
    }
    @objc func share(){
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(activityController, animated: true, completion: nil)
    }
    @objc func safari(){
        guard let url = URL(string: url) else{return}
        let safariView = SFSafariViewController(url: url)
        safariView.delegate = self
        safariView.dismissButtonStyle = .close
        safariView.preferredControlTintColor = .black   
        present(safariView, animated: true, completion: nil)
    }
    func frameAndLayer(){
        shareButton.layer.cornerRadius = shareButton.frame.height/2
        safariButton.layer.cornerRadius = safariButton.frame.height/2
        shareButton.layer.shadowOpacity = 0.3
        shareButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        safariButton.layer.shadowOpacity = 0.3
        safariButton.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
        
}

