
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let url = Bundle.main.url(forResource: "video", withExtension: "m4v")!
        let playerViewController = MyPlayerViewController()
        playerViewController.player = MyPlayer(url: url)
        
        window?.rootViewController = playerViewController
        window?.makeKeyAndVisible()
        return true
    }
}
