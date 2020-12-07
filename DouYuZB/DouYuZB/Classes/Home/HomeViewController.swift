//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/7.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }

}

extension HomeViewController{
    private func setupUI(){
        setNavigationBar()
    }
    
    private func setNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
}
