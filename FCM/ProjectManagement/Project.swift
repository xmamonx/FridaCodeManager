import Foundation

let ProjectsPath = docsDir()

struct Project: Identifiable {
    let id = UUID()
    var Name: String
    var BundleID: String
    var Version: String
    var ProjectPath: String
    var Executable: String
    var SDK: String
    var TG: String
}

func GetProjects() -> [Project] {
    do {
        var Projects: [Project] = []
        for Item in try FileManager.default.contentsOfDirectory(atPath: ProjectsPath) {
            if let Info = NSDictionary(contentsOfFile: "\(ProjectsPath)/\(Item)/Resources/Info.plist"), let BundleID = Info["CFBundleIdentifier"] as? String, let Version = Info["CFBundleVersion"] as? String, let Executable = Info["CFBundleExecutable"] as? String, let TG = Info["MinimumOSVersion"] as? String {

           if let Info2 = NSDictionary(contentsOfFile: "\(ProjectsPath)/\(Item)/Resources/DontTouchMe.plist"), let SDK = Info2["SDK"] as? String, let Name = Info2["ProjectName"] as? String {
                Projects.append(Project(Name: Name, BundleID: BundleID, Version: Version, ProjectPath: "\(ProjectsPath)/\(Item)", Executable: Executable, SDK: SDK, TG: TG))
                }
            }
        }
        return Projects
    } catch {
        print(error)
        return []
    }
}

//TODO: Use NSDictionary!!
func MakeApplicationProject(_ Name: String, _ BundleID: String, SDK: String, type: Int) {
    let v2uuid = UUID()
    let rvch = """
#import <UIKit/UIKit.h>

@interface myRootViewController : UIViewController

@end
"""
    let rvc = """
#import "myRootViewController.h"

@interface myRootViewController () <UITableViewDataSource>
@property (nonatomic, strong) UITableView *logTableView;
@property (nonatomic, strong) NSMutableArray *logEntries;
@end

@implementation myRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"ObjevtiveC support!";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];

    // Create and configure UITableView for log display
    self.logTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.logTableView.dataSource = self;
    [self.view addSubview:self.logTableView];

    // Initialize log entries array
    self.logEntries = [NSMutableArray array];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logEntries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = self.logEntries[indexPath.row];
    return cell;
}

- (void)addButtonTapped:(id)sender {
    @try {
        // Add log entry
        NSString *logEntry = @"Hello, World!";
        [self.logEntries insertObject:logEntry atIndex:0];

        // Update UITableView
        [self.logTableView reloadData];
    } @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    } @finally {
        NSLog(@"Add button tapped");
    }
}

@end
"""
    let apdh = """
#import <UIKit/UIKit.h>

@interface myAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *rootViewController;

@end
"""
    let apd = """
#import "myAppDelegate.h"
#import "myRootViewController.h"

@implementation myAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[UINavigationController alloc] initWithRootViewController:[[myRootViewController alloc] init]];
	_window.rootViewController = _rootViewController;
	[_window makeKeyAndVisible];
	return YES;
}

@end
"""
    let mainv = """
#import <Foundation/Foundation.h>
#import "myAppDelegate.h"

int main(int argc, char *argv[]) {
	@autoreleasepool {
		return UIApplicationMain(argc, argv, nil, NSStringFromClass(myAppDelegate.class));
	}
}
"""

    let mainh = """
#import <Foundation/Foundation.h>

@interface MyObjectiveCClass : NSObject

- (NSString *)hello;

@end
"""
    let mainm = """
#import "main.h"

@implementation MyObjectiveCClass

- (NSString *)hello {
    return @"Hello ObjectiveC World!";
}

@end
"""
    let objcswift = """
import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
       Text(hello())
    }
    func hello() -> String {
        let myObjCInstance = MyObjectiveCClass()
        return myObjCInstance.hello()
    }
}
"""
    do {
        let ResourcesPath = "\(ProjectsPath)/\(v2uuid)/Resources"
        try FileManager.default.createDirectory(atPath: ResourcesPath, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: "\(ResourcesPath)/Info.plist", contents: Data("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n<dict>\n\t<key>CFBundleExecutable</key>\n\t<string>\(Name)</string>\n\t<key>CFBundleIdentifier</key>\n\t<string>\(BundleID)</string>\n\t<key>CFBundleName</key>\n\t<string>\(Name)</string>\n\t<key>CFBundleShortVersionString</key>\n\t<string>1.0</string>\n\t<key>CFBundleVersion</key>\n\t<string>1.0</string>\n\t<key>MinimumOSVersion</key>\n\t<string>14.0</string>\n\t<key>UILaunchScreen</key>\n\t<dict>\n\t\t<key>UILaunchScreen</key>\n\t\t<dict/>\n\t</dict>\n</dict>\n</plist>".utf8))

FileManager.default.createFile(atPath: "\(ResourcesPath)/DontTouchMe.plist", contents: Data("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n<dict>\n\t<key>ProjectName</key>\n\t<string>\(v2uuid)</string>\n\t<key>SDK</key>\n\t<string>\(SDK)</string>\n</dict>\n</plist>".utf8))
        
switch(type) {
    case 1:
FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/My App.swift", contents: Data("import SwiftUI\n\n@main\nstruct MyApp: App {\n    var body: some Scene {\n        WindowGroup {\n            ContentView()\n        }\n    }\n}".utf8))
        FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/ContentView.swift", contents: Data("import SwiftUI\n\nstruct ContentView: View {\n    var body: some View {\n       Text(\"Hello, World!\")\n    }\n}".utf8))
    break
    case 2:
FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/main.m", contents: mainv.data(using: .utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/myAppDelegate.h", contents: apdh.data(using: .utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/myAppDelegate.m", contents: apd.data(using: .utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/myRootViewController.h", contents: rvch.data(using: .utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/myRootViewController.m", contents: rvc.data(using: .utf8))
    break;
    case 3:
FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/My App.swift", contents: Data("import SwiftUI\n\n@main\nstruct MyApp: App {\n    var body: some Scene {\n        WindowGroup {\n            ContentView()\n        }\n    }\n}".utf8))
        FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/ContentView.swift", contents: objcswift.data(using: .utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/bridge.h", contents: Data("#import \"main.h\"".utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/main.h", contents: mainh.data(using: .utf8))

FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/main.m", contents: mainm.data(using: .utf8))
    default:
        return
}
        FileManager.default.createFile(atPath: "\(ProjectsPath)/\(v2uuid)/entitlements.plist", contents: Data("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n<dict>\n\t<key>platform-application</key>\n\t<true/>\n</dict>\n</plist>".utf8))
    } catch {
        print(error)
    }
}
