//
//  userDetailsVC.swift
//  AlamofireUser
//
//  Created by Praveer on 27/06/20.
//  Copyright © 2020 Praveer. All rights reserved.
//

import UIKit

class userDetailsVC: UIViewController {

    @IBOutlet weak var oUsertable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        oUsertable.dataSource = self
        oUsertable.delegate = self
        oUsertable.rowHeight = 100
        oUsertable.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        oUsertable.reloadData()
    }

    @IBAction func ActionLogout(_ sender: Any) {
        gUserid = ""
        gPassword = ""
        dismiss(animated: true, completion: nil)
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
    @IBAction func ActionAddNewUser(_ sender: Any) {
        let NewUser = NewUserVC()
        NewUser.modalPresentationStyle = .custom
        self.present(NewUser, animated: true, completion: nil)
    }
    
    @IBAction func ActionCloseApp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    @objc func refreshTable(){
        oUsertable.reloadData()
    }
}

extension userDetailsVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let oCell = oUsertable.dequeueReusableCell(withIdentifier: C_USERDETAILCELL, for: indexPath) as? userDetailsCell else {return UITableViewCell()}
        oCell.updateCellvalues(index: indexPath)
        return oCell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: C_DELETE) { (rowaction, indexpath) in
            ServiceProcess.instance.deleteuser(userid: iDisplay[indexPath.row].id) { (response) in
                if response == true{
                    self.oUsertable.deleteRows(at: [indexPath], with: .automatic)
                    self.oUsertable.reloadData()
                }
            }
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.6145051122, green: 0.1419887841, blue: 0.1185588911, alpha: 1)
        
        let updateAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: C_UPDATE) { (rowaction, indexpath) in
            ServiceProcess.instance.initUpdateUser(index: indexpath.row)
            let oUpdateView = NewUserVC()
            oUpdateView.modalPresentationStyle = .custom
            self.present(oUpdateView, animated: true, completion: nil)
        }
        updateAction.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        return [deleteAction, updateAction]
    }
    
}
