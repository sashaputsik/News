import UIKit

class AllNewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All news"
        navigationController?.isNavigationBarHidden = false
        
        print(tableView.contentSize)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else{return UITableViewCell()}
        let new = articles[indexPath.row]
        cell.titleTextLabel.text = new.title
        let date = new.publishedAt
        let date1 = date.dropLast(10)
        cell.dateTextLabel.text = "\(date1)"
        guard let url = URL(string: new.urlToImage) else{return UITableViewCell()}
        guard let data = try? Data(contentsOf: url) else{return UITableViewCell()}
            cell.newImageView.image = UIImage(data: data)
        cell.newImageView.layer.cornerRadius = 15
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else{return}
        let news = articles[indexPath.row]
        vc.author = news.author
        vc.titleText = news.title
        vc.content = news.content
        vc.urlToImage = "\(news.urlToImage)"
        vc.url = "\(news.url)"
        vc.sourceName = news.name
    
        showDetailViewController(vc, sender: nil)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

}
