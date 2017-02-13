# IOS-FirstApp
Simple hello world app I created via IOS using Xcode with Swift





![output_ije1qa](https://cloud.githubusercontent.com/assets/11635523/22900028/83c77248-f1f2-11e6-9819-aabec1d2c49e.gif)


```swift

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var welcomeBtn: UIButton!
    @IBOutlet weak var titleImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func welcomePressed(_ sender: Any) {
        background.isHidden = false
        titleImg.isHidden = false
        welcomeBtn.isHidden = true
    }

}

```
