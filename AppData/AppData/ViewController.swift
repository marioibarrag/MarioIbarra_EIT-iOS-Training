import UIKit

class ViewController: UIViewController {

    @IBAction func execute() {
        executeTest()
    }
    
    func executeTest() {
        let count = 100
        let q = DispatchQueue(label: "q")
        for index in 0..<count {
            AppData.shared.set(value: index, key: String(index))
        }
        
        q.sync {
            for i in 0..<count {
                if let n = AppData.shared.object(key: String(i)) as? Int{
                    print(n)
                }
            }
        }
        
//        DispatchQueue.concurrentPerform(iterations:count) { (index) in
//            if let n = AppData.shared.object(key: String(index)) as? Int{
//                print(n)
//            }
//        }
        
        AppData.shared.reset()
        
        q.async {
            for i in 0..<count {
                AppData.shared.set(value:i,key:String(i))
            }
        }
        
//        DispatchQueue.concurrentPerform(iterations:count) { (index) in
//            AppData.shared.set(value:index,key:String(index))
//        }
    }
}

