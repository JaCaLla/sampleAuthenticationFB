//
//  sampleAuthenticationFBApp.swift
//  sampleAuthenticationFB
//
//  Created by Javier Calatrava on 24/11/24.
//
import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct sampleAuthenticationFBApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


    var body: some Scene {
      WindowGroup {
        NavigationView {
          ContentView()
        }
      }
    }
}
