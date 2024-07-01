
import UIKit

class PlanDetailViewController: UIViewController {

    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var placeText: UITextField!
    
    
    var plan: Plan?
    var saveChangeDelegate: ((Plan)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typePicker.dataSource = self
        typePicker.delegate = self
        
        plan = plan ?? Plan(date: Date(), withData: true)
        dateDatePicker.date = plan?.date ?? Date()
        ownerLabel.text = plan?.owner     

        // typePickerView 초기화
        if let plan = plan{
            typePicker.selectRow(plan.kind.rawValue, inComponent: 0, animated: false)
        }
       contentTextView.text = plan?.content
        placeText.text = plan?.place
        

    }
    
    @IBAction func Search(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {
                    return
                }
        webViewController.wtxt = contentTextView.text ?? ""

        navigationController?.pushViewController(webViewController, animated: true)

    }
    
    @IBAction func OpenAI(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let chatViewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else {
                    return
                }
        chatViewController.ctxt = contentTextView.text ?? ""

        navigationController?.pushViewController(chatViewController, animated: true)
        
    }
    
    @IBAction func Map(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
                    return
                }
        mapViewController.mtxt = placeText.text ?? ""

        navigationController?.pushViewController(mapViewController, animated: true)
    }
    


    override func viewWillDisappear(_ animated: Bool) {
        plan!.date = dateDatePicker.date
        plan!.owner = ownerLabel.text   
        plan!.kind = Plan.Kind(rawValue: typePicker.selectedRow(inComponent: 0))!
        plan!.content = contentTextView.text
        plan!.place = placeText.text ?? ""

        saveChangeDelegate?(plan!)
    }

}


extension PlanDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Plan.Kind.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = Plan.Kind.init(rawValue: row)
        return type?.toString()
    }
    
}



