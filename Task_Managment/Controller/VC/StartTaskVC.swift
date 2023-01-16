//
//  StartTaskVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit
import CircleProgressView
import GoogleMaps
import SkeletonView


class StartTaskVC: UIViewController {
    
    
    @IBOutlet weak var timerStack: UIStackView!
    @IBOutlet weak var timerView: CircleProgressView!
    @IBOutlet weak var timerTitleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var laddressLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var gmsMap: GMSMapView!
    @IBOutlet weak var startFinishBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var startTaskBtn: UIButton!
    
    @IBOutlet weak var datELbl: UILabel!
    @IBOutlet weak var timELbl: UILabel!
    @IBOutlet weak var locatioNLbl: UILabel!
    
    //variables
    var task: TaskDM?
    var timer: Timer!
    var total = 0
    var totalTime = 0
    var hour = 0
    var minute = 0
    var second = 0
    var value = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerStack.isHidden = true
        setUpNav()
        setUpUI()
        setLang()
        setUpUI()
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if timer == nil {
                setUpTimer()
                Vibration.success.vibrate()
                startFinishBtn.setTitle("Finish Task", for: .normal)
            } else {
                navigationController?.popViewController(animated: true)
            }
            
        }
    }
    //SetUpUI
    
    func setUpUI() {
        
        guard let data = task else { return }
        self.dateLbl.text = dateFormatter(unixDate: data.from)
        self.laddressLbl.text = data.address
        self.totalTime = data.deadline
        self.total = self.totalTime
        self.titleLbl.text = data.title
        self.timeLbl.text = "\(dateFormatter(unixDate: data.from, isDate: false)) - \(dateFormatter(unixDate: data.to, isDate: false))"
        self.descLbl.text = data.definition
        self.timerLbl.text = "\(data.deadline)"
        setUPMap(lat: data.location.latitude, long: data.location.longitude)
        
    }
    //  SetUpMap
    func setUPMap(lat: Double, long: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 5.0)
        gmsMap.camera = camera
        showMarker(position: camera.target)
        gmsMap.settings.scrollGestures = false
        gmsMap.settings.zoomGestures = false
        gmsMap.settings.tiltGestures = false
        gmsMap.settings.rotateGestures = false
        
    }
    //    ShowMarket
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.map = gmsMap
    }
    
    
    func dateFormatter(unixDate: Int, isDate: Bool = true) -> String{
        
        if let timeResult = unixDate as? Int {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let dateFormatter = DateFormatter()
            if isDate {
                dateFormatter.timeStyle = DateFormatter.Style.none//Set time style
                dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
                dateFormatter.dateFormat = "dd-MM-yyyy"
            } else {
                dateFormatter.timeStyle = DateFormatter.Style.short//Set time style
                dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
                dateFormatter.dateFormat = "HH:mm"
            }
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
    }
    
    
    func setUpTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timerStack.isHidden {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                self.timerStack.isHidden = false
            }
        }
        
        self.hour = totalTime / 3600
        if hour == 0 {
            self.minute = totalTime / 60
            self.second = totalTime % 60
        } else {
            self.minute = (totalTime - hour*3600) / 60
            self.second = totalTime % 60
        }
        value = Double(totalTime)/Double(total)
        print(value)
        self.timerView.setProgress(self.value, animated: true)
        self.timerLbl.text = "\(self.hour):\(self.minute):\(self.second)"
        self.totalTime -= 1
        if self.totalTime <= 0 {
            Vibration.warning.vibrate()
            self.timer.invalidate()
            self.timer = nil
            self.totalTime = 0
            self.timerLbl.text = "Time Out"
        }
        
        
    }
    
    
    //MARK: language settings
    func setLang() {
        datELbl.text = Lang.getString(type: .datE)
        timELbl.text = Lang.getString(type: .timE)
        locatioNLbl.text = Lang.getString(type: .locatioN)
        timerTitleLbl.text = Lang.getString(type: .totalTime)
        commentBtn.setTitle(Lang.getString(type: .comment), for: .normal)
        startTaskBtn.setTitle(Lang.getString(type: .startTask), for: .normal)
    }
    
    
    
    func setUpNav() {
        self.navigationItem.backButtonTitle = ""
        let alertBtn = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .done, target: self, action: #selector(alertTapped))
        
        alertBtn.tintColor = .black
        
        
        self.navigationItem.rightBarButtonItems = [alertBtn]
    }
    
    @objc func alertTapped() {
        let vc = ChatsVC.loadFromNib()
        vc.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    @IBAction func commentTapped(_ sender: Any) {
        ChatsVC.loadFromNib().navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(ChatsVC.loadFromNib(), animated: true)
    }
    
    
    
    
    
    @IBAction func startTaskTapped(_ sender: UIButton) {
        
        if timer == nil {
            setUpTimer()
            Vibration.success.vibrate()
            startFinishBtn.setTitle("Finish Task", for: .normal)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
}


//MARK: - Google Maps Delegate
extension StartTaskVC: GMSMapViewDelegate{
}

//MARK: - NnotificationCenter for language changing
extension StartTaskVC {
    func observeLangNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(changLang), name: NSNotification.Name.init(rawValue: "LANGNOTIFICATION"), object: nil)
        print("NotificationCenter StartTaskVC")
    }
    @objc func changLang(_ notification: NSNotification) {
        guard let lang = notification.object as? Int else { return }
        switch lang {
        case 0:
            Cache.save(appLanguage: .uz)
            setLang()
        case 1:
            Cache.save(appLanguage: .ru)
            setLang()
        case 2:
            Cache.save(appLanguage: .en)
            setLang()
        default: break
        }
    }
}
////MARK: - Google Maps Delegate
//extension StartTaskVC: GMSMapViewDelegate{
//
//}

