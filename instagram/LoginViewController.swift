//
//  LoginViewController.swift
//  instagram
//
//  Created by 佐々木駿 on 2019/07/28.
//  Copyright © 2019 shun.sasaki. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var mailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var displayNameField: UITextField!
    
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            if address.isEmpty || password.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: password) {user, error in
                if let error = error {
                    print("DEBUG:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
                    return
                }
                print("DEBUG: ログインに成功しました")
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }

        
    }
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameField.text{
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                print("DEBUG: 何かが空白です")
                return
            }
            
            SVProgressHUD.show()
            
            Auth.auth().createUser(withEmail: address, password: password) {user, error in
                if let error = error {
                    print("DEBUG:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "アカウント作成に失敗しました")
                    return
                }
                print("ユーザ作成が成功しました")
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges{error in
                        if let error = error {
                            print("DEBUG:" + error.localizedDescription)
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました")
                            return
                        }
                        print("表示名を設定しました")
                        SVProgressHUD.dismiss()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
