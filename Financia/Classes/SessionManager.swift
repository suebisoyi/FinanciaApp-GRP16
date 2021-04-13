//
//  SessionManager.swift
//  Financia
//
//  Created by Gagandeeep Ghotra
//         Using Auth0-SessionManager sample class on 2021-04-10.
//

import Foundation
import Auth0

public class SessionManager {
    static let shared = SessionManager()
    public let authentication = Auth0.authentication()
    let credentialsManager: CredentialsManager!
    var profile: UserInfo?
    var credentials: Credentials?
    var patchMode: Bool = false
    
    public init () {
        self.credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        _ = self.authentication.logging(enabled: true)
    }
    
    func retrieveProfile(_ callback: @escaping (Error?) -> ()) {
        guard let accessToken = self.credentials?.accessToken
        else { return callback(CredentialsManagerError.noCredentials)}
        
        self.authentication
            .userInfo(withAccessToken: accessToken)
            .start {
                result in
                switch(result) {
                case .success(let profile):
                    self.profile = profile
                    callback(nil)
                case .failure(let error):
                    callback(error)
                }
            }
    }
    
    func renewAuth(_ callback: @escaping (Error?) -> ()) {
        guard self.credentialsManager.hasValid() else {
            return callback(CredentialsManagerError.noCredentials)
        }
        
        self.credentialsManager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                return callback(error)
            }
            
            self.credentials = credentials
            callback(nil)
            
        }
    }
    
    func logout(_ callback: @escaping (Error?) -> Void) {
        self.credentials = nil
        self.credentialsManager.revoke(callback)
    }
    
    func store(credentials: Credentials) -> Bool {
        self.credentials = credentials
        return self.credentialsManager.store(credentials: credentials)
    }
}
