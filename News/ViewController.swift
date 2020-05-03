import UIKit
//http://newsapi.org/v2/everything?q=bitcoin&from=2020-04-03&sortBy=publishedAt&apiKey=69698df82a724ba9b3979013183abb34
class ViewController: UIViewController {
        let urlString = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-04-03&sortBy=publishedAt&apiKey=69698df82a724ba9b3979013183abb34"
        var articles: [Articles] = []
        @IBOutlet weak var tableView: UITableView!
        let cellId = "cell"
        var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        let back = UIBarButtonItem()
        back.title = ""
        navigationItem.backBarButtonItem = back
        let view = UIImageView()
        view.image = UIImage(named: "logo2.png")
        navigationItem.titleView = view
        tableView.delegate = self
        tableView.dataSource = self
        guard let url = URL(string: urlString) else {return}
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
            }
        }.resume()
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for:indexPath) as? TableViewCell else{return UITableViewCell() }
        let new = articles[indexPath.row]
        cell.titleTextLabel.text = new.title
        cell.dateTextLabel.text = new.publishedAt
  
        if let urlToImage = new.urlToImage{
            if let data = try? Data(contentsOf:urlToImage ){
                let image = UIImage(data: data)
                cell.newImageView.image = image
        }
            }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else {return}
        if  let title = articles[indexPath.row].title,
            let urlToImage = articles[indexPath.row].urlToImage,
            let content = articles[indexPath.row].content, let url = articles[indexPath.row].url {
                vc.titleText = title
                vc.imageUrl = "\(urlToImage)"
                vc.contentText = content
                vc.url = "\(url)"
                vc.author = articles[indexPath.row].author!
        }
        if let source = articles[indexPath.row].source{
            if let sourceName = source.name{
                vc.source = sourceName
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        }
    
}
