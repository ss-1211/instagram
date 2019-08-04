//
//  PostData.swift
//  instagram
//
//  Created by 佐々木駿 on 2019/07/30.
//  Copyright © 2019 shun.sasaki. All rights reserved.
//

import Foundation
import Firebase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var commentFull : [String] = []
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        self.caption = valueDictionary["caption"] as? String
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
    
        for likedId in self.likes {
            if likedId == myId {
                self.isLiked = true
                break
            }
        }
        if let commentFull = valueDictionary["commentFull"] as? [String] {
            self.commentFull = commentFull
        }
    }
}


