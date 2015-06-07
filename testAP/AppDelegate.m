//
//  AppDelegate.m
//  testAP
//
//  Created by Sterch on 06.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import "AppDelegate.h"
#import "APImageCreater.h"
#import <Realm/Realm.h>
#import "APAlbum.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
      Так как нет четких инструкций по обновлени контекста, данные парсятся и мапятся 1 раз, если инфа есть в бд, альбом повторно не создается, сдесь можно реализовать логику проверки обновления, например сравнивая объекты из бд с серверными по time stamp
     */
    if ([APAlbum allObjects].count == 0) {
        APImageCreater *creator = [[APImageCreater alloc]init];
        [creator createDataAlbum:@"http://www.placecage.com/g/200/300"   name:@"Cage Gray Album"];
        [creator createDataAlbum:@"http://www.placecage.com/c/200/300"   name:@"Cage Crazy Album"];
        [creator createDataAlbum:@"http://placekitten.com/g/200/300"     name:@"Kitten special album"];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
