//
//  ViewController.swift
//  Firebase_facebook
//
//  Created by IPS-149 on 16/03/23.
//
// https://iosapptemplates.com/blog/swift-programming/firebase-swift-tutorial-login-registration-ios
// https://palsmadhu18.medium.com/facebook-authentication-with-firebase-using-swift-for-ios-5b979e8c260a

import UIKit
import FacebookCore
import FacebookLogin
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {
  override func viewDidLoad() {
      super.viewDidLoad()
      let loginButton = FBLoginButton()
      loginButton.delegate = self
      loginButton.center = view.center
      view.addSubview(loginButton)
      loginButton.permissions = ["public_profile","email"]
  }

  func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
      if let error = error {
          print(error.localizedDescription)
      return
      }
      let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
      Auth.auth().signIn(with: credential) { (authResult, error) in
        if let error = error {
          print("Facebook authentication with Firebase error: ", error)
          return
        }
          if let username = authResult?.additionalUserInfo?.profile {
                     print("User's Facebook username: \(username)")
                 } else {
                     print("Could not retrieve user's Facebook username")
                 }
        print("Login success!")
      }

  }

  func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
     print("Logged out")
  }
}
