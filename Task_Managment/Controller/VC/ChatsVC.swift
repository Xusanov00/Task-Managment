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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comment"
        textTf.layer.cornerRadius = 12
        sendBtn.layer.cornerRadius = sendBtn.frame.width/2
        backV.addShadow(cornerRadius: 0)
        textTf.addShadow(cornerRadius: 12)
        sendBtn.addShadow(cornerRadius: sendBtn.frame.width/2)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
