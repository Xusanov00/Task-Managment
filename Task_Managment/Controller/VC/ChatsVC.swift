//
//  ChatsVC.swift
//  Task_Managment
//
//  Created by MacBook Pro on 07/01/23.
//

import UIKit

class ChatsVC: UIViewController {

    @IBOutlet weak var backV:UIView!
    @IBOutlet weak var textTf:UITextField!
    @IBOutlet weak var sendBtn:UIButton!
    @IBOutlet weak var tableView: UITableView!
    var get:String = "salom"
    var send:String = "qonday ey"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comment"
        textTf.layer.cornerRadius = 12
        sendBtn.layer.cornerRadius = sendBtn.frame.width/2
        backV.addShadow(cornerRadius: 0)
        textTf.addShadow(cornerRadius: 12)
        sendBtn.addShadow(cornerRadius: sendBtn.frame.width/2)
        setUpTableView()
    }

    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "GetTVC", bundle: nil), forCellReuseIdentifier: "GetTVC")
        tableView.register(UINib(nibName: "SendTVC", bundle: nil), forCellReuseIdentifier: "SendTVC")
    }

}
extension ChatsVC:UITableViewDelegate {
    
}
extension ChatsVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let getcell = tableView.dequeueReusableCell(withIdentifier: "GetTVC", for: indexPath) as? GetTVC else {return UITableViewCell()}
        guard let sendcell = tableView.dequeueReusableCell(withIdentifier: "SendTVC", for: indexPath) as? SendTVC else {return UITableViewCell()}
       
       
        return sendcell
    }
}
