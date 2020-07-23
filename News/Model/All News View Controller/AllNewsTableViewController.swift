import UIKit

class AllNewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let date = new.publishedAt{
            let date1 = date.dropLast(10)
            cell.dateTextLabel.text = "\(date1)"
        }
        if let urlToImage = new.urlToImage{
            guard let data = try? Data(contentsOf: urlToImage) else{return UITableViewCell()}
            cell.newImageView.image = UIImage(data: data)
        }
        cell.newImageView.layer.cornerRadius = 15
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "oneNew") as? OneNewViewController else{return}
        if let title = articles[indexPath.row].title,
            let content = articles[indexPath.row].content,
            let urlToImage = articles[indexPath.row].urlToImage,
            let author = articles[indexPath.row].author,
            let url = articles[indexPath.row].url{
            vc.author = author
            vc.title = title
            vc.content = content
            vc.urlToImage = "\(urlToImage)"
            vc.url = "\(url)"
        }
        if let source = articles[indexPath.row].source{
            guard let sourceName = source.name else{return}
            vc.sourceName = sourceName
        }
        showDetailViewController(vc, sender: nil)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

}
