//
//  AuthProvider.swift
//  Realtime Tracker Customer
//
//  Created by bookr on 9/23/18.
//  Copyright © 2018 bookr. All rights reserved.
//

import Foundation
import Firebase

typealias LoginHandler = (_ msg: String?) -> Void;

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address";
    static let WRONG_PASSWORD = "Wrong Password";
    static let PROBLEM_CONNECTING = "Problem Connecting to Database";
    static let USER_NOT_FOUND = "User Not Found";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use";
    static let WEAK_PASSWORD = "Password Minimum of 8 Characters";
}


class Authprovider {
    private static let _instance = Authprovider();
    
    static var Instance: Authprovider {
        return _instance
    }
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
    Auth.auth().signIn(withEmail: withEmail, password: password, completion: {(user, error) in
            
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler);
            } else {
                loginHandler?(nil);
                
            }
        });
        
    } // login func
    
    func signUp(withEmail: String, password: String, loginHandler: LoginHandler?) {
        
        Auth.auth().createUser(withEmail: withEmail, password: password, completion:  {(user, error)  in
            
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            } else {
                
                if user?.user.uid != nil {
                    
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler);
                    
                }
                
            }
        })
    }
    
    func logOut() -> Bool {
        if (Auth.auth().currentUser != nil) {
            do {
                try Auth.auth().signOut();
                return true;
            } catch {
                return false;
            }
        }
        return true;
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        if let errCode = AuthErrorCode(rawValue: err.code) {
            
            switch errCode {
                
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break;
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE)
                break;
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL)
                break;
            case .userNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND)
                break;
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD)
                break;
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
                break;
                
                
            }
        }
    }
}
