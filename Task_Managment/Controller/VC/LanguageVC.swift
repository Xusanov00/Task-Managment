//
//  LanguageVC.swift
//  TaskManagement
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class LanguageVC: UIViewController {

    
    @IBOutlet weak var langTablView: UITableView!
    
    var languageArr: [LanguageDM] = [
        LanguageDM(image: "uzbF", language: "O'zbekcha"),
        LanguageDM(image: "rusF", language: "Русский"),
        LanguageDM(image: "engF", language: "English"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLangTableView()
    }
    
    //tableView registration
    func setLangTableView() {
        langTablView.separatorStyle = .none
        langTablView.dataSource = self
        langTablView.register(LanguageTVC.nib(), forCellReuseIdentifier: LanguageTVC.id)
    }


    @IBAction func continueTapped(_ sender: Any) {
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func languageTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            SetCache.saveCache(for: LanguageEnum.uz.rawValue, for: KeysDM.language)
        case 1:
            SetCache.saveCache(for: LanguageEnum.ru.rawValue, for: KeysDM.language)
        case 2:
            SetCache.saveCache(for: LanguageEnum.en.rawValue, for: KeysDM.language)
        default:
            print("error select language button tag")
        }
    }
    
}


extension LanguageVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = langTablView.dequeueReusableCell(withIdentifier: LanguageTVC.id, for: indexPath) as? LanguageTVC else {return UITableViewCell()}
        cell.cellView.addShadow(cornerRadius: 12)
        cell.updateCell(cell: languageArr[indexPath.row])
        return cell
    }
    
    
}
