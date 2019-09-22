//
//  my_journis_vc.swift
//  app_travel
//
//  Created by HaiPhan on 7/31/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class my_journis_vc: UIViewController {

    var search : UISearchBar!
    var collect: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
       setup_view()
    }

    func setup_view(){
        search_autolayout()
        collection_autolayout()

    }
    override func viewWillAppear(_ animated: Bool) {
        setup_navigation()
    }

    func collection_autolayout(){
        collect = FunctionAll.share.createCollectionView(colorBR: .white)
        self.view.addSubview(collect)
        collect.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.search.snp.bottom)
        }
        collect.register(my_journis_cell.self, forCellWithReuseIdentifier: "cell")
        collect.register(my_journis_first_cell.self, forCellWithReuseIdentifier: "first_cell")
        collect.delegate = self
        collect.dataSource = self
    }
    var search_bar_top: NSLayoutConstraint?

    func search_autolayout(){
        search = UISearchBar()
        self.view.addSubview(search)
//        search.frame = CGRect(x: 0, y: 96 + 20 , width: 96, height: 50)
        search.placeholder = ConstantText.share.txtSearchMyJournis
        search.barTintColor = UIColor.white
        search.layer.borderColor = UIColor.white.cgColor
        search.layer.borderWidth = 5
//        search.backgroundColor = UIColor.darkGray
//        search.barTintColor = UIColor.darkGray
        search.tintColor = UIColor.darkGray
        _ = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.size.height

        search.translatesAutoresizingMaskIntoConstraints = false
        search.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        search.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        search.heightAnchor.constraint(equalToConstant: 50).isActive = true
        search_bar_top = search.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64)
        search_bar_top!.isActive = true

        search.delegate = self
        let searchTextField = search.value(forKey: "_searchField") as? UITextField
        searchTextField?.backgroundColor = UIColor.lightGray
        searchTextField?.textColor = UIColor.white
    }
    
    
    func setup_navigation(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.createNavigationViewInTabBar(statusBar: .default, titlerLarge: true, title: ConstantText.share.txtMyJournis)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: ConstantText.share.txtFollowing,
                                                                 style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        check when User scroll to bot
//        let height = scrollView.frame.size.height
//        let contentYoffset = scrollView.contentOffset.y
//        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//        if distanceFromBottom > height {
//            print(" you reached end of the table")
//        }
        if scrollView.contentOffset.y > -8.0 {
            self.navigationController?.navigationBar.prefersLargeTitles = false
            let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.size.height
            search_bar_top?.constant = height
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        else if scrollView.contentOffset.y <= -8.0
        {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.size.height
            search_bar_top?.constant = height
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }

}
extension my_journis_vc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collect.dequeueReusableCell(withReuseIdentifier: "first_cell", for: indexPath) as! my_journis_first_cell
            return cell
        }
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! my_journis_cell
        cell.backgroundColor = UIColor.orange
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 40) / 2, height:  self.view.bounds.height / 2 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let new = create_journi()
            new.modalTransitionStyle = .crossDissolve
            new.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(new, animated: true)
            return
        }
        let detail = journi_detail()
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)

    }

}
extension my_journis_vc: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //custom lại ui
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//        let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.size.height
        search_bar_top?.constant = 20
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        //hiển thị button cacne
        search.setShowsCancelButton(true, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //customize UI
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
        let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.size.height
        search_bar_top?.constant = height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
//         self.navigationController?.navigationBar.isHidden = false
        search.text = nil
        //ẩn button cancel
        search.setShowsCancelButton(false, animated: false)
        //xoá focus từ search
        search.endEditing(true)
    }
}
