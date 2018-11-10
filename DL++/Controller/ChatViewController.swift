import UIKit
import Alamofire

struct Messages: Codable {
    let allMessages: [String]
}


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        messageTableView.delegate = self
        messageTableView.dataSource = self
        getData()
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyBoard(sender: UITapGestureRecognizer? = nil){
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.selectionStyle = .none
        cell.messageBody.text = saveData[indexPath.row]
        
        return cell
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.saveData.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    var saveData = [String]()

    func getData() {
        
        let url = "https://dlhackday.herokuapp.com/getAllMessages"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            do {
                guard let result = response.data else { return }
                let res = try JSONDecoder().decode(Messages.self, from: result)
                self.saveData = res.allMessages
                self.tableView.reloadData()
                if !res.allMessages.isEmpty {
                    self.scrollToBottom()
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return saveData.count
        
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        let URL = "https://dlhackday.herokuapp.com/sendMessage"
        let parameters: Parameters = ["message": messageTextfield.text!]

        Alamofire.request(URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                self.getData()
                self.messageTextfield.text = ""
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
    }
    
}
