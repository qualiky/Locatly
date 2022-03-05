//
//  MailSender.swift
//  Locatly
//
//  Created by Sandeep Gautam on 05/03/2022.
//

import Foundation
import skpsmtpmessage

class MailSender : NSObject, SKPSMTPMessageDelegate{
    
    static let shared = MailSender()
    
    func sendEmail(to: String, subject: String, body: String) {
            let message = SKPSMTPMessage()
            message.relayHost = "smtp.gmail.com"
            message.login = "sandeep.infinitydigital@gmail.com"
            message.pass = ""
            message.requiresAuth = true
            message.wantsSecure = true
            message.relayPorts = [587]
            message.fromEmail = "sandeep.infinitydigital@gmail.com"
            message.toEmail = to
            message.subject = subject
            let messagePart = [kSKPSMTPPartContentTypeKey: "text/plain; charset=UTF-8", kSKPSMTPPartMessageKey: body]
            message.parts = [messagePart]
            message.delegate = self
            message.send()
        }

        func messageSent(_ message: SKPSMTPMessage!) {
            print("Successfully sent email!")
        }

        func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
            print("Sending email failed!")
        }
}
