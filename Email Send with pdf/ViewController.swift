//
//  ViewController.swift
//  Email Send with pdf
//
//  Created by Adwait Barkale on 08/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSendEmailClicked(_ sender: UIButton) {
        
        guard MFMailComposeViewController.canSendMail() else { return }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["adwaitbarkale@gmail.com"])
        composer.setSubject("Xcode Email Tutorial")
        composer.setMessageBody("Email Send from iOS APP Swift 4", isHTML: true)
        self.present(composer,animated: true,completion: nil)
        
        if let filePath = Bundle.main.path(forResource: "sample", ofType: "pdf")
        {
            if let fileData = NSData(contentsOfFile: filePath)
            {
                composer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "sample.pdf")
            }
        }
    }
    
}

extension ViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error{
            controller.dismiss(animated: true, completion: nil)
        }
        switch result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        default:
            print("Default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

