//
//  ViewController.swift
//  Sample
//
//  Created by Shilpa Bansal on 14/06/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import UIKit
enum EncryptionError: Error {
  case Empty
  case Short
}
class ViewController: UIViewController
{
  override func viewDidLoad()
  {
    super.viewDidLoad()
   
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    
    let testCaughtExceptionButton = UIButton(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
    testCaughtExceptionButton.backgroundColor = UIColor.gray
    testCaughtExceptionButton.setTitle("Test Caught Exception", for: .normal)
    testCaughtExceptionButton.addTarget(self, action: #selector(caughtExcpetionAction), for: .touchUpInside)
    testCaughtExceptionButton.layer.cornerRadius = 3;
    self.view.addSubview(testCaughtExceptionButton)
    
    let testUncaughtExceptionButton = UIButton(frame: CGRect(x: 50, y: 200, width: 300, height: 50))
    testUncaughtExceptionButton.backgroundColor = UIColor.gray
    testUncaughtExceptionButton.setTitle("Test Uncaught Exception", for: .normal)
    testUncaughtExceptionButton.addTarget(self, action: #selector(uncaughtExcpetionAction), for: .touchUpInside)
    testUncaughtExceptionButton.layer.cornerRadius = 3;
    self.view.addSubview(testUncaughtExceptionButton)
    
    let testReactButton = UIButton(frame: CGRect(x: 50, y: 300, width: 300, height: 50))
    testReactButton.backgroundColor = UIColor.gray
    testReactButton.setTitle("Test React Crash", for: .normal)
    testReactButton.addTarget(self, action: #selector(reactCrashAction), for: .touchUpInside)
    testReactButton.layer.cornerRadius = 3;
    self.view.addSubview(testReactButton)
  }
  
  func encryptString(str: String, withPassword password: String) throws -> String
  {
    guard password.characters.count > 0 else { throw EncryptionError.Empty }
    guard password.characters.count >= 5 else { throw EncryptionError.Short }
    let encrypted = password + str + password
    return String(encrypted.characters.reversed())
  }
  
  func caughtExcpetionAction()
  {
    do {
      let encrypted = try self.encryptString(str:"secret information!", withPassword: "")
      print(encrypted)
    } catch EncryptionError.Empty {
      print("You must provide a password.")
    } catch EncryptionError.Short {
      print("Passwords must be at least five characters, preferably eight or more.")
    } catch {
      print("Something went wrong!")
    }
  }
  
  func uncaughtExcpetionAction()
  {
    let array = NSArray.init()
    array.object(at: 23)
  }
  
  func reactCrashAction()
  {
    var jsCodeLocation : URL?
    #if TEST_ENVIRONMENT
      jsCodeLocation = NSURL(string: "http://localhost:9091/index.ios.bundle?platform=ios&dev=true")
    #else
    #if TARGET_IPHONE_SIMULATOR
      jsCodeLocation = NSURL(string: "http://localhost:8081/index.ios.bundle?platform=ios&dev=true")
    #else
      jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    #endif
    #endif
    
    let bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: nil)
    
    let reactRootView = RCTRootView(bridge: bridge, moduleName: "Sample", initialProperties: nil)
    self.view.addSubview(reactRootView!);
    reactRootView?.frame = self.view.bounds
  }
}
