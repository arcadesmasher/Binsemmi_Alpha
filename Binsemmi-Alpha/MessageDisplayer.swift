//
//  MessageDisplayer.swift
//  Binsemmi-Alpha
//
//  Created by Deniz on 22.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation
import UIKit

class MessageDisplayer
{
    public func dispMessage(sender : UIViewController, mesaj: String)
    {
        let alertController = UIAlertController(title: "Binsem mi?", message:mesaj, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        sender.present(alertController, animated: true, completion: nil)
    }
    
}
