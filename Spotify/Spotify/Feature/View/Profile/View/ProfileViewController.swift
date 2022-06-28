//
//  ProfileViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 27.06.2022.
//

import Foundation
import UIKit


class ProfileViewController : UIViewController {
      // MARK:  properties
   let tableView = UITableView(frame: .zero, style: .grouped)

      // MARK: Lifecyle


      // MARK: Selectors

   override func viewDidLoad() {
      super.viewDidLoad()
      configureNavBar()
      configureTableView()
   }

      // MARK:  Makers

   func configureNavBar() {
      Utilities.configureNavBar(vc: self, title: "Profile")
      navigationController?.navigationBar.tintColor = .systemGreen
   }
   func configureTableView() {
   view.addSubview(tableView)
     tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      tableView.delegate = self
      tableView.dataSource = self
      tableView.snp.makeConstraints { make in
         make.left.top.right.bottom.equalTo(view)
      }
   }
}


extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 10
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

      return cell
   }

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80
   }


}

