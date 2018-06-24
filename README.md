# TabControllerApp

-- Clone, download, etc, run and try it out.


## How to make a Tabbed app

 1. Create project with an awesome name (unlike this repo haha). It doesn't matter if it's Tabbed app or Single view because at the end, you have to perform step 2.
 2. Delete Main.storyboard, as well as in your project settings, in General->Deployment info->Main interface.
 3. Create a new file either Cocoa touch or empty swift file (or rename the default ViewController.swift which came with your new project), name it MainViewController or whatever you need it to be named
 4. Let the magic begin.
 
### Approaches

 1. What I did. 

As I pointed out in step 3 from previous section, a file named MainViewController was created, which is a class of type UITabBarController.

Since no xib or storyboard is needed you then add the inits!

	init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

Then you setup the tab items, like so:

	func setupTabItems() -> Void {
        // create ViewControllers for each tab
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()

        //set tab items' name, icon and tag
        firstVC.tabBarItem = UITabBarItem(title: "First", image: #imageLiteral(resourceName: "first"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: #imageLiteral(resourceName: "second"), tag: 1)

        //set items to tab bar controller and select default tab
        viewControllers = [firstVC, secondVC]
        selectedViewController = viewControllers?.first
    }

You call that from viewDidLoad or viewWillAppear and there you go, tab items are setup!

Of course, creating the class as instructed, is not entirely necessary, but I prefer it that way, because that way we keep code contained, the single responsability principle comes into play. This way on the `appDelegate`, in `didFinishLaunchingWithOptions`, you only set the `rootViewController`.

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        return true
    }

2. Ditch the MainViewController class.

You can avoid creating the MainViewController file/class and simply go to `appDelegate` and do the whole setup there, I don't particularly like that but it's about preferences, and I prefer to leave `appDelegate` as clean as possible and not give it another responsability, to create AND set the `rootViewController`.

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        //create tab bar items/ViewControllers
        let tabController = UITabBarController()
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()

        //set tab items' name, icon and tag
        firstVC.tabBarItem = UITabBarItem(title: "First", image: #imageLiteral(resourceName: "first"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: #imageLiteral(resourceName: "second"), tag: 1)

        //set items to tab bar controller and select default tab
        tabController.viewControllers = [firstVC, secondVC]
        tabController.selectedViewController = tabController.viewControllers?.first

        window?.rootViewController = tabController

        window?.makeKeyAndVisible()
        return true
    }
 
 ## Base Classes
 
Personally, I try to avoid base classes for `UIViewControllers` because when it's a big team, and a big project, sometimes people take shotcuts and fill the base classes with unnedded code which leads to refactoring in the future.

As you saw before, `init()` and `required init?(coder aDecoder: NSCoder)` are in the main `UITabBarController`, and it's not that bad because as a "main" view there's only ever gonna be one. But, in the case of `UIViewControllers` and in this particular case because we are avoinding xibs and storyboards, to prevent having to write boilerplate code we can do a base class for the `UIViewController`.

	class BaseViewController: UIViewController {
        //Custom init -- To remove xibs/storyboards
        init() {
            super.init(nibName: nil, bundle: nil)
            commonInit()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        func commonInit() -> Void {
            view.backgroundColor = UIDefaults.palette.vcBackground
            configureView()
        }

        internal func configureView() -> Void {}
    }

You could only have `configureView` and call it in the inits, but in this case I do it as you see because I want the same background color on all viewControllers, and if not done this way, you'd have to either set the color on each `configureView` call, or, put in in the configureView and make sure when you override it always call `super.configureView()`.

### Views generatic closures

In order to have clearer and cleaner code, when creating a label, instead of having a big method, creating, customizing, adding as subview, configuring constraints, repeat for each label. Lets  clean that up:

	class FirstViewController: BaseViewController {
        private var titleLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.text = title
            label.font = UIFont.boldSystemFont(ofSize: UIDefaults.fontSize.title)
            label.textColor = color
            label.numberOfLines = 1
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        ...
    }

There, you took the creating OUT of the configureView method by creating an invoked closure... but hey, what if you have to use a another label JUST like that, you'd have to repeat code... lets not do that, and instead do what's done in Views+Library.swift:

	let titleLabel: (String, UIColor) -> UILabel = { (title, color) in
        let label = UILabel(frame: .zero)
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: UIDefaults.fontSize.title)
        label.textColor = color
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

...and maybe even:

	let defaultTitleLabel: (String) -> UILabel = { (title) in
        return titleLabel(title, UIDefaults.palette.title)
    }

so now our viewController will be as such:

	class FirstViewController: BaseViewController {
	    lazy var lblViewName: UILabel = defaultTitleLabel("First view")
        
        ...
    }

Much cleaner and reusable.

Now all that's left to be done is to use `configureView` to add subviews and constraints:

	override func configureView() -> Void {
        view.addSubview(lblViewName)
        lblViewName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblViewName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lblViewName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        lblViewName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
    }
    
## That's it.

That's all, check the whole code, clone or download the project. If there's something I could've done better, let me know by creating an issue.
