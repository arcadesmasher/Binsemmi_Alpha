//
//  PlakaEkleViewController.swift
//  Binsemmi-Alpha
//
//  Created by Deniz on 28.05.2017.
//  Copyright © 2017 Deniz. All rights reserved.
//

import Foundation
import UIKit

class PlakaEkleViewController : UIViewController, UITextViewDelegate
{
    
    
    @IBOutlet weak var txtPlaka: UITextField!
    @IBOutlet weak var txtSokak: UITextField!
    @IBOutlet weak var txtSemt: UITextField!
    @IBOutlet weak var txtBolge: UITextField!
    @IBOutlet weak var txtSehir: UITextField!
    @IBOutlet weak var txtYorumlar: UITextField!
    @IBOutlet weak var sldPuan: UISlider!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.txtPlaka.delegate = self as? UITextFieldDelegate
        self.txtSokak.delegate = self as? UITextFieldDelegate
        self.txtSemt.delegate = self as? UITextFieldDelegate
        self.txtBolge.delegate = self as? UITextFieldDelegate
        self.txtSehir.delegate = self as? UITextFieldDelegate
        self.txtYorumlar.delegate = self as? UITextFieldDelegate
    }
    
    @IBAction func gonder_Clicked(_ sender: Any)
    {
        let dalOperations = DALOperations()
        dalOperations.insertDriver(bdc: generateBnsDriverComment(), completionHandler: {(UIBackgroundFetchResult) -> Void in
            let msgDisp = MessageDisplayer()
            msgDisp.dispMessage(sender: self, mesaj: "Plaka ekleme başarılı.")
        })
    }
    
    private func generateBnsDriverComment() -> BnsCommentData
    {
        let bdc = BnsCommentData(CommentId: 0,
                                    PlateNo: txtPlaka.text!,
                                    Street: txtSokak.text!,
                                    Town: txtSemt.text!,
                                    Region: txtBolge.text!,
                                    City: txtSehir.text!,
                                    Comment: txtYorumlar.text!,
                                    Commentator: UIDevice.current.identifierForVendor!.uuidString,
                                    DriverPoint: Int(sldPuan.value * 10))
        return bdc
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField : UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
}
