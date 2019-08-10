//
//  create_journi.swift
//  app_travel
//
//  Created by HaiPhan on 8/2/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import ImagePicker
import QBImagePickerController

class create_journi: UIViewController {
    
    let img = UIImageView()
    var view_line: UIView!
    var text_center: UILabel!
    var collect: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setup_view()
    }
    
    func setup_view(){
        navigation_autolayout()
        img_selected_autolayout()
        text_img_autolayout()
        view_line_autolayout()
        text_center_autolayout()
        collect_autolayout()
    }
    
    func collect_autolayout(){
        let layout = UICollectionViewFlowLayout()
        collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(collect)
        
        collect.translatesAutoresizingMaskIntoConstraints = false
        collect.topAnchor.constraint(equalTo: self.text_center.bottomAnchor, constant: 0).isActive = true
        collect.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        collect.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 30).isActive = true
        collect.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func text_center_autolayout(){
        text_center = UILabel()
        text_center.text = "or start an empty Journi & add photos later."
        text_center.font = UIFont.systemFont(ofSize: 12)
        text_center.textAlignment = .center
        self.view.addSubview(text_center)
        
        text_center.translatesAutoresizingMaskIntoConstraints = false
        text_center.topAnchor.constraint(equalTo: self.view_line.bottomAnchor, constant: 0).isActive = true
        text_center.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        text_center.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        text_center.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func view_line_autolayout(){
        view_line = UIView()
        view_line.backgroundColor = UIColor.gray
        self.view.addSubview(view_line)
        
        view_line.translatesAutoresizingMaskIntoConstraints = false
        view_line.topAnchor.constraint(equalTo: self.img.bottomAnchor, constant: 8).isActive = true
        view_line.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        view_line.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        view_line.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func text_img_autolayout(){
        var lb = UILabel()
        lb.text = "SELECT PHOTOS"
        lb.font = UIFont.systemFont(ofSize: 30)
        lb.textAlignment = .center
        lb.textColor = UIColor.orange
        self.view.addSubview(lb)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.topAnchor.constraint(equalTo: self.img.topAnchor, constant: 0).isActive = true
        lb.centerXAnchor.constraint(equalTo: self.img.centerXAnchor, constant: 0).isActive = true
        lb.widthAnchor.constraint(equalTo: self.img.widthAnchor, multiplier: 1).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func img_selected_autolayout(){
        
        img.image = UIImage(named: "")
        img.backgroundColor = UIColor.black
        img.layer.cornerRadius = 10
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle_show_img)))
        self.view.addSubview(img)
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8 + 20 + 44 ).isActive = true
        img.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        img.widthAnchor.constraint(equalToConstant: self.view.frame.width - 30).isActive = true
        img.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc func handle_show_img(){
        let img_picker : QBImagePickerController = QBImagePickerController()
        img_picker.delegate = self
        img_picker.allowsMultipleSelection = true
        img_picker.showsNumberOfSelectedAssets = true
//        img_picker.sourceType = .photoLibrary
        present(img_picker, animated: true, completion: nil)
    }
    
    func navigation_autolayout(){
        let navigation = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 44))
//        navigation.backgroundColor = UIColor.red
        self.view.addSubview(navigation)
        
        navigation.isTranslucent = false
        
        let navigation_item : UINavigationItem = UINavigationItem(title: "Create Journi")
        navigation.setItems([navigation_item], animated: true)
        
        navigation_item.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handle_cancel))
        
    }
    
    @objc func handle_cancel(){
        dismiss(animated: true, completion: nil)
    }


}
extension create_journi: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img_chossen = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        img.image = img_chossen
        dismiss(animated: true, completion: nil)
    }
}
extension create_journi: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        img.image = images.first
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
extension create_journi: QBImagePickerControllerDelegate {
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didSelect asset: PHAsset!) {
        
    }
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        var array_temp : [UIImage] = [UIImage]()
        for i in assets {
            let text = getAssetThumbnail(asset: i as! PHAsset)
            array_temp.append(text)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
        let new = journi_detail()
        new.isCheck_move_from_create = true
//        new.array_img = array_temp
        self.navigationController?.pushViewController(new, animated: true)
    }
  

}
extension UIViewController {
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
