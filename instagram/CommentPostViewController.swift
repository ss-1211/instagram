//
//  CommentPostViewController.swift
//  instagram
//
//  Created by 佐々木駿 on 2019/07/31.
//  Copyright © 2019 shun.sasaki. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentPostViewController: UIViewController {
    
    var postArray:PostData!
    var indexAt: Int = 0
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func handleCommentPostButton(_ sender: UIButton) {
        
        let postRef = Database.database().reference().child(Const.PostPath).child(postArray.id!)
        //ここで配列に入れる
        let commentedUser = Auth.auth().currentUser?.displayName
        let comment = commentedUser! + String(":") + commentTextField.text! + String("\n")
        
        //配列に入れる
        postArray.commentFull.append(comment)
        
        let commentFull = ["commentFull" : postArray.commentFull]
        
        postRef.updateChildValues(commentFull)
        
        SVProgressHUD.showSuccess(withStatus: "コメント投稿しました")
        
        dismiss(animated: true, completion: nil)
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
