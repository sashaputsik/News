import UIKit

class AllNewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All news"
        navigationController?.isNavigationBarHidden = false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else{return UITableViewCell()}
        let oneNews = articles[indexPath.row]
        cell.titleTextLabel.text = oneNews.title
        let date = Parse().parseNews(date: oneNews.publishedAt)
        cell.dateTextLabel.text = date
        guard let url = URL(string: oneNews.urlToImage) else{return UITableViewCell()}
        guard let data = try? Data(contentsOf: url) else{return UITableViewCell()}
            cell.newImageView.image = UIImage(data: data)
        cell.newImageView.layer.cornerRadius = UITableViewCell.Appearance().cornerRadius
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else{return}
        let oneNews = articles[indexPath.row]
        vc.author = oneNews.author
        vc.titleText = oneNews.title
        vc.content = oneNews.content
        vc.urlToImage = "\(oneNews.urlToImage)"
        vc.url = "\(oneNews.url)"
        vc.sourceName = oneNews.name
        showDetailViewController(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

}
