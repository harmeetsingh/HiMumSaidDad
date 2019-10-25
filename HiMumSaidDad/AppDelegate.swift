import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties

    var window: UIWindow?

    // MARK - UIApplicationDelegate    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
  
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else {
            fatalError("No UI Window")
        }

        let coordinatorFactory = CoordinatorFactory()
        let beersListCoordaintor = coordinatorFactory.makeBeersList()
        beersListCoordaintor.start(on: window)

        return true
    }
}

