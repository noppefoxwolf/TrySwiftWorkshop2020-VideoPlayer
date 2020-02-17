
import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let url = Bundle.main.url(forResource: "video", withExtension: "m4v")!
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: url)
        
        window?.rootViewController = playerViewController
        window?.makeKeyAndVisible()
        return true
    }
}
