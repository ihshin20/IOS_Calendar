import UIKit
import WebKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var MapView: WKWebView!
    var mtxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let mtxtEncoding = mtxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union(.urlFragmentAllowed)) ?? ""
        
        let urlStr = "https://m.map.naver.com/search2/search.naver?query=" + mtxtEncoding

        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        MapView.load(request)
    }
    

}
