import UIKit
import SafariServices
class OneNewViewController: UIViewController {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var loadActivityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var sourceTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    
    var titleText = ""
    var contentText = ""
    var imageUrl = ""
    var url = ""
    var source = ""
    var author = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        newImageView.layer.cornerRadius = 20
        var barButtonItems = [UIBarButtonItem]()
        let safari =  UIBarButtonItem(image: UIImage(named: "compass.png"),
                                      style: .done, target: self,
                                      action: #selector(openSafari))
        let share = UIBarButtonItem(barButtonSystemItem: .action,
                                    target: self,
                                    action: #selector(shared))
        safari.tintColor = #colorLiteral(red: 0.3543371856, green: 0.7160425782, blue: 1, alpha: 1)
        barButtonItems.append(safari)
        barButtonItems.append(share)
        navigationItem.rightBarButtonItems = barButtonItems
        DispatchQueue.main.async {
            self.contentTextView.text = self.contentText
            self.titleTextLabel.text = self.titleText
            self.authorTextLabel.text = self.author
            self.sourceTextLabel.text = self.source
            guard let urlImage = URL(string: self.imageUrl) else{return}
            if let dataImage = try? Data(contentsOf: urlImage){
                self.newImageView.image = UIImage(data: dataImage)
                self.loadActivityIndicator.isHidden = true
            }
        }
    }
    @objc func openSafari(){
        guard let urlSafari = URL(string: url) else{return}
        let svc = SFSafariViewController(url: urlSafari )
        svc.preferredControlTintColor = #colorLiteral(red: 0.3543371856, green: 0.7160425782, blue: 1, alpha: 1)
        present(svc, animated: true, completion: nil)
    }
    @objc func shared(){
        guard let urlShared = URL(string: url) else{return}
        guard let image = newImageView.image else {return}
        let activity = UIActivityViewController(activityItems: [urlShared,
                                                                image],
                                                applicationActivities: nil)
        present(activity, animated: true,
                completion: nil   )
        
    }
}
