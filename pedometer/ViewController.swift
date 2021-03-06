//
//  ViewController.swift
//  pedometer
//
//  Created by Kazama Ryusei on 2017/03/13.
//  Copyright © 2017年 Malfoy. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var myPedometer: CMPedometer!
    
    func layout() {
        // 歩数のレイアウトを変更
        stepsLabel.layer.borderColor = UIColor.orange.cgColor
        stepsLabel.layer.borderWidth = 1
        stepsLabel.layer.cornerRadius = 8
        stepsLabel.layer.masksToBounds = true
    }
    
    func pedcounter() {
        // 歩数計生成
        myPedometer = CMPedometer()
        
        // 歩数計で計測開始
        myPedometer.startUpdates(from: NSDate() as Date, withHandler: {(pedometerData, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            guard let data = pedometerData else {
                return
            }
            DispatchQueue.main.async {
                // 歩数表示
                let mystep = data.numberOfSteps
                self.stepsLabel.text = "\(mystep)歩"
                print(mystep)
                
                if Int(mystep) < 51 {
                    self.statusLabel.text = "運動不足です！"
                } else if Int(mystep) > 50 && Int(mystep) < 100 {
                    self.statusLabel.text = "もっと歩きましょ！"
                } else {
                    self.statusLabel.text = "頑張りました！"
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.layout()
        self.pedcounter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

