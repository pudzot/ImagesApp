//
//  Extensions.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 01/12/2023.
//

import Foundation
import UIKit

extension UIViewController{
    
    public func showAlertMessage(title: String, message: String){
        
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }
}
