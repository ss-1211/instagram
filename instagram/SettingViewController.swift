//
//  SettingViewController.swift
//  instagram
//
//  Created by 佐々木駿 on 2019/07/28.
//  Copyright © 2019 shun.sasaki. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import ESTabBarController

class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    
    
    @IBAction func handleChangeDisplayNameButton(_ sender: Any) {
        if let displayname = displayNameTextField.text {
            if displayname.isEmpty {
                SVProgressHUD.showError(withStatus: "表示名が空白です")
                return
            }
            let user = Auth.auth().currentUser
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = displayname
            SVProgressHUD.show()
            changeRequest?.commitChanges() {error in
                if let error = error {
                    print("DEBUG:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "変更時にエラーが発生しました")
                    return
                }
                SVProgressHUD.dismiss()
                return
            }
        }
        self.view.endEditing(true)
    }
    
    @IBAction func handleLogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        // ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
        let tabBarController = parent as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNameTextField.text = Auth.auth().currentUser?.displayName
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
