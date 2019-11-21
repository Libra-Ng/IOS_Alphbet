//
//  ViewController.swift
//  ios-exam-1
//
//  Created by liushangwei on 2019/11/16.
//  Copyright © 2019 zhouhaijian. All rights reserved.
//

import UIKit

class ImgView:UIView{

    override func draw(_ rect: CGRect) {
    
    let roundedRect = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 30, height: 30), cornerRadius: 5)
        
        roundedRect.lineWidth = 1
        UIColor.red.setStroke()
        roundedRect.stroke()
       
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var move: UIButton!
    @IBOutlet weak var clear: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var add2: UIButton!
    lazy var animator:UIDynamicAnimator = UIDynamicAnimator(referenceView: self.mainView)
    let gravity = UIGravityBehavior()
    let collison = UICollisionBehavior()
    
    let gravity2 = UIGravityBehavior()
    var zm:Int = 0
    var yj:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        collison.translatesReferenceBoundsIntoBoundary = true
       
        gravity2.gravityDirection = CGVector(dx: 1, dy: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    @IBAction func addZhiMu(_ sender: Any) {
        
        let zhimu:UILabel = UILabel()
        
        let screenWidth = Int(mainView.bounds.width/10)
  
        let randomX = Int(arc4random()%10)*screenWidth
        zhimu.frame = CGRect(x: randomX, y: 100, width: 18, height: 18)
        zhimu.backgroundColor = .red

        let randomCh = Int(arc4random()%26)
        zhimu.text = String(Character(UnicodeScalar(65+randomCh)!))
        zhimu.textAlignment = .center
 
        mainView.addSubview(zhimu)
        gravity.addItem(zhimu)
        collison.addItem(zhimu)
        upMove()
        zm+=1
        label1.text = "ZM:\(zm)"
    }
    
    @IBAction func zhiMuMove(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        animator.addBehavior(gravity)
        animator.addBehavior(collison)
    }
    func upMove() -> Void {
        animator.addBehavior(gravity)
        animator.addBehavior(collison)
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        
    }
    func rightMove() -> Void {
        animator.addBehavior(gravity)
        animator.addBehavior(collison)
        gravity.gravityDirection = CGVector(dx: 1, dy: 0)
    }
    @IBAction func addRect(_ sender: Any) {
        let screenHeight = Int(mainView.bounds.height/25)
        let randomX = Int(arc4random()%25)*screenHeight
        let roundRect = ImgView(frame: CGRect(x: 10, y: randomX, width: 32, height: 32))
        roundRect.backgroundColor = UIColor.clear
        mainView.addSubview(roundRect)
        gravity.addItem(roundRect)
        collison.addItem(roundRect)
        rightMove()
        yj+=1
        label2.text = "YJ:\(yj)"
    }
    @IBAction func clearAll(_ sender: Any) {
        for item in mainView.subviews {
            if item is UILabel{
                item.removeFromSuperview()
                gravity.removeItem(item)
                collison.removeItem(item)
            }
            else if item is ImgView{
                item.removeFromSuperview()
                gravity.removeItem(item)
                collison.removeItem(item)
            }
        }
        zm = 0
        yj = 0
        label1.text = "ZM:\(zm)"
        label2.text = "YJ:\(yj)"
   }
}
