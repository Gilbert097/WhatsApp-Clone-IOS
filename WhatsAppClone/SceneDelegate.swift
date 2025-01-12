//
//  SceneDelegate.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit
import BackgroundTasks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigation = NavigationController()
        let coordinator = LoginCoordinatorImpl(navigation: navigation)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.windowScene = windowScene
        self.window?.rootViewController = navigation
        
        coordinator.show()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        submitBackgroundTask()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground called!")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground called!")
    }
    
    private func submitBackgroundTask() {

        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: AppDelegate.taskId)
        
        // check if there is a pending task request or not
        BGTaskScheduler.shared.getPendingTaskRequests { request in
            print("\(request.count) BGTask pending.")
            guard request.isEmpty else { return }
            // Create a new background task request
            let request = BGProcessingTaskRequest(identifier: AppDelegate.taskId)
            request.requiresNetworkConnectivity = false
            request.requiresExternalPower = false
            //request.earliestBeginDate = Date().addingTimeInterval(86400 * 3)
            
            do {
                // Schedule the background task
                try BGTaskScheduler.shared.submit(request)
                
                // Manual test: e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"whatsapp.clone.background.task.identifier"]
                // Colocar break point na linha 82 e executar,  ao parar na linha, executa script acima no log.
                print("Task scheduled")
            } catch {
                print("Unable to schedule background task: \(error.localizedDescription)")
            }
        }
    }
    
}
