import Foundation

var articles = [Articles]()

struct Articles {
    var author: String
    var title: String
    var discription: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
    var name: String
    
    init(article: [String:Any]) {
        self.author = article["author"] as? String ?? ""
        self.content = article["content"] as? String ?? ""
        self.discription = article["discription"] as? String ?? ""
        self.name = (article["source"] as? [String:Any] ?? ["":""])["name"] as? String ?? ""
        self.publishedAt = article["publishedAt"] as? String ?? ""
        self.url = article["url"] as? String ?? ""
        self.urlToImage = article["urlToImage"] as? String ?? ""
        self.title = article["title"] as? String ?? ""
    }
    
}


class Parse{
    func loadNews(of value: Int, complitionHandler: (()->())?){
        guard let url = URL(string: NewsResource().urlStringArray[value]) else{return}
        print(url)
        let session = URLSession.shared
        session.downloadTask(with: url) { (data, response, error) in
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
            print(path)
            guard let data = data else{return}
            let urlPath = URL(fileURLWithPath: path)
            try? FileManager.default.copyItem(at: data, to: urlPath)
            self.parseNews()
            complitionHandler?()
        }.resume()
    }
    func parseNews(){
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else{return}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else{return}
        guard let articlesJson = json["articles"] as? [[String: Any]] else{return}
        var resultArray = [Articles]()
        for dict in articlesJson{
            let new = Articles(article: dict)
            resultArray.append(new)
            print(resultArray)
        }
        articles = resultArray
    }
}

