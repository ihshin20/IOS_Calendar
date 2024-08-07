
import UIKit
class Owner{
    static var owner: String?
    static func loadOwner(sender: UIViewController){ // sender은 present함수를 위해서 필요하다
        if let owner = UserDefaults.standard.string(forKey: "owner"){ // preferences에 이미 있다면
            Owner.owner = owner; return     // 읽어서 저장하고 리턴한다
        }
        // preference에 없으면 사용자로부터 입력받아 저장해 둔다.
        let alertController = UIAlertController(title: "Owner", message: "Owner을 입력하세요", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)     // 텍스트빌드를 여러개 입력할 수 있다. 여기서는 1개만
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
            if let owner = alertController.textFields?[0].text{ 
                Owner.owner = owner
                UserDefaults.standard.set(owner, forKey: "owner") // preferences에 저장한다.
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        sender.present(alertController, animated: true, completion: nil)
    }
    static func getOwner() -> String{
        if let owner = Owner.owner{return owner } // 읽혀진게 있으면 owner을 리턴
        return ""       // 없으면 “”를 리턴
    }
}
