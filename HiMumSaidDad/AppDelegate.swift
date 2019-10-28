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

        let network = NetworkSession(session: URLSession.shared, domain: "https://api.punkapi.com")
        let database: Database = UserDefaults.standard

        let coordinatorFactory = CoordinatorFactory(network: network, database: database)
        let brersGridCoordaintor = coordinatorFactory.makeBeersGrid()
        brersGridCoordaintor.start(on: window)

        return true
    }
}

