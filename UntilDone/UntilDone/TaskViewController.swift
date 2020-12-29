import RealmSwift
import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let realm = try! Realm()
    
    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?
    
    //DateFormatter takes up a lot of memory, thus we only want to create it 1 time. Hence static
    static let dateFormatter: DateFormatter = {     //taking date object and formatting it into String
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc func didTapDelete(){
        
        guard let myItem = self.item else{
            return
        }
        
        realm.beginWrite()
        realm.delete(myItem)
        
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }

}
