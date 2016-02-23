import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        checkInternetConnection(preparationForStartApp)

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        checkInternetConnection(preparationForStartApp)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        checkInternetConnection(preparationForStartApp)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let reachability: AMReachability
        do {
            reachability = try AMReachability.reachabilityForInternetConnection()
            if reachability.isReachable() {
                DeviceTokenData.create(deviceToken.description as NSString as String)
            }
        } catch {
            print("Unable to create Reachability")
        }
    }

    private func preparationForStartApp() {
        getUuid()
        googleAnalyticsTracking()
        Fabric.with([Crashlytics.self])
        self.logUser()
    }

    private func checkInternetConnection(callback: () -> Void) {
        let reachability: AMReachability
        do {
            reachability = try AMReachability.reachabilityForInternetConnection()
            if reachability.isReachable() {
                print("Internet connection is OK")
                callback()
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewControllerWithIdentifier("NoNetworkViewController")
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
        } catch {
            print("Unable to create Reachability")
        }
    }

    private func getUuid() {
        if (UserIdData.get() == nil) {
            UserIdData.create()
        }
    }

    private func googleAnalyticsTracking() {
        // Configure tracker from GoogleService-Info.plist.
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")

        // Optional: configure GAI options.
        let gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        //gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
    }

    func logUser() {
        Crashlytics.sharedInstance().setUserIdentifier(UserIdData.get())

        // TODO: Use the current user's information
        // You can call any combination of these three methods
        //Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        //Crashlytics.sharedInstance().setUserName("Test User")
    }
}