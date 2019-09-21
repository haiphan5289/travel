//
//  JourniDetailCell.swift
//  app_travel
//
//  Created by HaiPhan on 8/9/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import GoogleMaps
import QBImagePickerController

class JourniDetailCell: UICollectionViewCell {
    var imgCover: UIImageView!
    let viewTitle = UIView()
    var titlelb : UILabel!
    var imgtitle: UIImageView!
    var MoreButton: UIButton!
    var mapview: GMSMapView!
    private let locationManage = CLLocationManager()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupView()
        
        locationManage.delegate = self
        locationManage.requestWhenInUseAuthorization()
    }
    
    func setupView(){
        imgCoverAutoLayout()
        setupTitle()
        setupViewAction()
        setupViewMap()
    }
    let viewMap = UIView()
    func setupViewMap(){
//        viewMap.backgroundColor = UIColor.blue
        self.addSubview(viewMap)
        
        viewMap.translatesAutoresizingMaskIntoConstraints = false
        viewMap.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        viewMap.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        viewMap.topAnchor.constraint(equalTo: self.viewTitle.bottomAnchor, constant: 0).isActive = true
        viewMap.bottomAnchor.constraint(equalTo: self.viewAction.topAnchor, constant: 0).isActive = true
        
        setupObjectViewMap()
    }
    
    func setupObjectViewMap(){
        setupMapViewAutoLayout()
    }
    
    func setupMapViewAutoLayout(){
        mapview = GMSMapView()
        mapview.settings.setAllGesturesEnabled(false)
        self.viewMap.addSubview(mapview)
        
        mapview.translatesAutoresizingMaskIntoConstraints = false
        mapview.leftAnchor.constraint(equalTo: self.viewMap.leftAnchor, constant: 0).isActive = true
        mapview.bottomAnchor.constraint(equalTo: self.viewMap.bottomAnchor, constant: 0).isActive = true
        mapview.widthAnchor.constraint(equalTo: self.viewMap.widthAnchor, constant: 0).isActive = true
        mapview.heightAnchor.constraint(equalTo: self.viewMap.heightAnchor, multiplier: 0.85).isActive = true
    }
    
    let viewAction = UIView()
    func setupViewAction(){
        self.addSubview(viewAction)
        
        viewAction.translatesAutoresizingMaskIntoConstraints = false
        viewAction.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        viewAction.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        viewAction.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        viewAction.heightAnchor.constraint(equalToConstant: 150).isActive = true

    }
    
    
    func setupTitle(){
//        viewTitle.backgroundColor = UIColor.gray
        self.addSubview(viewTitle)
        
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        viewTitle.topAnchor.constraint(equalTo: self.imgCover.bottomAnchor, constant: 0).isActive = true
        viewTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        setupTitleAutolayout()
    }
    
    func setupTitleAutolayout(){
        setupIMGTitle()
        setupTitleText()
        MoreButtonAutolayout()
    }
    
    func MoreButtonAutolayout(){
        MoreButton = UIButton()
        MoreButton.setTitle("...", for: .normal)
        MoreButton.layer.cornerRadius = 15
        MoreButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        MoreButton.titleLabel?.textAlignment = .center
        MoreButton.contentVerticalAlignment = .center
        MoreButton.contentHorizontalAlignment = .center
        self.viewTitle.addSubview(MoreButton)
        
        MoreButton.translatesAutoresizingMaskIntoConstraints = false
        MoreButton.rightAnchor.constraint(equalTo: self.viewTitle.rightAnchor, constant: -16).isActive = true
        MoreButton.bottomAnchor.constraint(equalTo: self.imgtitle.bottomAnchor, constant: 0).isActive = true
        MoreButton.widthAnchor.constraint(equalToConstant: 30 ).isActive = true
        MoreButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupTitleText(){
        titlelb = UILabel()
        titlelb.text = "Điện Thoại"
        titlelb.font = UIFont.boldSystemFont(ofSize: 35)
        titlelb.numberOfLines = 2
        self.viewTitle.addSubview(titlelb)
        
        titlelb.translatesAutoresizingMaskIntoConstraints = false
        titlelb.leftAnchor.constraint(equalTo: self.imgtitle.rightAnchor, constant: 8).isActive = true
        titlelb.bottomAnchor.constraint(equalTo: self.imgtitle.bottomAnchor, constant: 13).isActive = true
        titlelb.rightAnchor.constraint(equalTo: self.viewTitle.rightAnchor, constant: -56).isActive = true
        titlelb.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupIMGTitle(){
        imgtitle = UIImageView()
        imgtitle.image = UIImage(named: "lock")
        self.viewTitle.addSubview(imgtitle)
        
        imgtitle.translatesAutoresizingMaskIntoConstraints = false
        imgtitle.leftAnchor.constraint(equalTo: self.viewTitle.leftAnchor, constant: 8).isActive = true
        imgtitle.topAnchor.constraint(equalTo: self.viewTitle.topAnchor, constant: 18).isActive = true
        imgtitle.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgtitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
   
    
    func imgCoverAutoLayout(){
        imgCover = UIImageView()
        imgCover.image = UIImage(named: "hai")
        imgCover.layer.borderWidth = 1
        imgCover.layer.borderColor = UIColor.darkGray.cgColor
        imgCover.contentMode = .scaleToFill
        self.addSubview(imgCover)
        
        imgCover.translatesAutoresizingMaskIntoConstraints = false
        imgCover.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imgCover.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imgCover.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        imgCover.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension JourniDetailCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManage.startUpdatingLocation()
        
        mapview.isMyLocationEnabled = true
        mapview.settings.myLocationButton = true
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.sorted(by: { $0.timestamp > $1.timestamp }).first else { return }
        
        mapview.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManage.stopUpdatingLocation()
    }
}
