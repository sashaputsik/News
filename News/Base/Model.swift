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
    
    init(article: [String: Any]) {
        self.author = article[ParseKeys.author.rawValue] as? String ?? ""
        self.content = article[ParseKeys.content.rawValue] as? String ?? ""
        self.discription = article[ParseKeys.discription.rawValue] as? String ?? ""
        self.name = (article[ParseKeys.source.rawValue] as? [String:Any] ?? ["":""])[ParseKeys.name.rawValue] as? String ?? ""
        self.publishedAt = article[ParseKeys.publishedAt.rawValue] as? String ?? ""
        self.url = article[ParseKeys.url.rawValue] as? String ?? ""
        self.urlToImage = article[ParseKeys.urlToImage.rawValue] as? String ?? ""
        self.title = article[ParseKeys.title.rawValue] as? String ?? ""
    }
    
}

//MARK: ParseKeys to init
private enum ParseKeys: String{
    case articles = "articles"
    case source = "source"
    case author = "author"
    case title = "title"
    case discription = "discription"
    case url = "url"
    case urlToImage = "urlToImage"
    case publishedAt = "publishedAt"
    case content = "content"
    case name = "name"
}

//MARK: Parse class
class Parse{
    
    func loadNews(of value: Int, needFunc: String?, complitionHandler: @escaping (()->())){
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
            complitionHandler()
            needFunc
        }.resume()
    }
    
    func parseNews(){
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else{return}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else{return}
        guard let articlesJson = json[ParseKeys.articles.rawValue] as? [[String: Any]] else{return}
        var resultArray = [Articles]()
        for dict in articlesJson{
            let new = Articles(article: dict)
            resultArray.append(new)
        }
        articles = resultArray
    }
}
