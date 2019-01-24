//
//  Client.swift
//  WordsCounter
//
//  Created by alessio on 24/01/2019.
//  Copyright © 2019 Giovannoli. All rights reserved.
//

import Foundation
import Siesta

class Client{
    
    func getText(url: String, onSuccess: ((String)->())?, onFailure: ((Error)->())?){
        let delegate = UntrustedCertificatesDelegate()
        let conf = URLSessionConfiguration.default
        let ns = URLSession(configuration: conf, delegate: delegate, delegateQueue: nil)
        let resource = Service(networking: ns).resource(absoluteURL: url)
        resource.load().onSuccess { (response) in
            if let text = response.content as? String{
                onSuccess?(text)
            }
            else{
                onFailure?(CustomError.runtimeError("The resource is not valid"))
            }
            }.onFailure { (error) in
                onFailure?(error)
        }
    }
    
}


class UntrustedCertificatesDelegate: NSObject, URLSessionDelegate{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust{
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }
    }
}

enum CustomError: Error {
    case runtimeError(String)
}

