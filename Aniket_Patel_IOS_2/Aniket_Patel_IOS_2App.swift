//
//  Aniket_Patel_IOS_2App.swift
//  Aniket_Patel_IOS_2
//
//  Created by Aniket Patel on 2021-08-14.
//

import SwiftUI
import Firebase

@main
struct Aniket_Patel_IOS_2App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
