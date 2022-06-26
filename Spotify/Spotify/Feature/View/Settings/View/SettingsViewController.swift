//
//  SettingsViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 27.06.2022.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
   // MARK: properties

   let viewModel = SettingsViewModel()
   let tableView : UITableView = {
      let tb = UITableView(frame: .zero, style: .grouped)

      return tb
   }()

   // MARK: Lifecyle

   // MARK: Selectors

   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .black

      Utilities.configureNavBar(vc: self, title: "Settings")
      configureChildViews()
      configureLayout()
   }

   // MARK: Makers

   func configureChildViews() {
      view.addSubview(tableView)
      view.backgroundColor = .systemBackground
      tableView.delegate = self
      tableView.dataSource = self
      tableView.separatorColor = .white

   }

   func configureLayout() {
      tableView.snp.makeConstraints { make in
         make.top.bottom.right.left.equalTo(view)
      }
   }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.sections[section].options.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let model = viewModel.sections[indexPath.section].options[indexPath.row]
      let cell = UITableViewCell()
      cell.backgroundColor = UIColor.black
      cell.textLabel?.text = model.title
      cell.textLabel?.textColor = .white
      return cell
   }



   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
      let model = viewModel.sections[indexPath.section].options[indexPath.row]
      model.handler(self)
   }

   func numberOfSections(in tableView: UITableView) -> Int {
      return viewModel.sections.count
   }

   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

      let model = viewModel.sections[section]
      return model.title
   }
}
