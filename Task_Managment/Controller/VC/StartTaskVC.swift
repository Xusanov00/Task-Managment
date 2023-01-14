//
//  StartTaskVC.swift
//  TaskManagement
//
//  Created by Chingiz Jumanov on 05/01/23.
//

import UIKit
import CircleProgressView
import GoogleMaps

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
    
    
    
    //variables
    var task: TaskDM?
    var timer: Timer!
    var value = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerStack.isHidden = true
        setUpNav()
        setUpUI()
    }
 
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if timer == nil {
                setUpTimer()
                Vibration.success.vibrate()
            }
            
        }
    }
//SetUpUI
    
    func setUpUI() {
        
        guard let data = task else { return }
        self.dateLbl.text = dateFormatter(unixDate: data.from)
        self.laddressLbl.text = data.address
        self.timeLbl.text = ""
        self.titleLbl.text = data.title
        self.descLbl.text = data.definition
        self.timerLbl.text = "\(data.deadline)"
        setUPMap(lat: data.location.latitude, long: data.location.longitude)
        
    }
//  SetUpMap
    func setUPMap(lat: Double, long: Double) {
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 6.0)
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
           marker.title = "Uzbekistan"
           marker.snippet = "Tashkent"
           marker.map = gmsMap
       }
    
    
    func dateFormatter(unixDate: Int) -> String{
          
        if let timeResult = unixDate as? Int {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none//Set time style
            dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
    }
    

    func setUpTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timerStack.isHidden {

            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn) {
                self.timerStack.isHidden = false
            }
        }
        
        self.timerView.setProgress(self.value, animated: true)
        self.timerLbl.text = "\(Int(self.value*100))"
        self.value += 0.01
        if self.value >= 1 {
            self.timer.invalidate()
            self.timer = nil
            self.value = 0.0
            self.timerLbl.text = "Time Out"
        }
        
        
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
        }
        
        sender.setTitle("Finish Task", for: .normal)
        
    }
}


//MARK: - Google Maps Delegate
extension StartTaskVC: GMSMapViewDelegate{
    
}

