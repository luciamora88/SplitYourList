//
//  SplitYourListApp.swift
//  SplitYourList
//
//  Created by Lucía Mora Serrano on 11/14/24.
//
import SwiftUI
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("Attempting to configure Firebase...")
        FirebaseApp.configure()
        return true
    }
}

@main
struct SplitYourListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
                ContentView()
        }
    }
}
