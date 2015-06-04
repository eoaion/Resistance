//
//  FiveViewController.swift
//  Resistance
//
//  Created by 虚空之翼 on 15/5/24.
//  Copyright (c) 2015年 虚空之翼. All rights reserved.
//

import UIKit
import QuartzCore

class FiveViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var colorValue: NSDictionary! //电阻颜色值
    var errorValue: NSDictionary! //误差值
    
    var firstValue: Int = 0
    var secondValue: Int = 0
    var threeValue: Int = 0
    var fourValue: Double = 1
    var fiveValue: Int = 0
    
    var finalValue: Double!
    
    @IBOutlet weak var resistanceValue: UILabel!
    @IBOutlet weak var resistanceErrorValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var colorDict: Dictionary = [0:"1Ω", 1:"10Ω", 2:"100Ω", 3:"1kΩ", 4:"10kΩ", 5:"100kΩ", 6:"1MΩ", 7:"10MΩ", 8:"0.1Ω", 9:"0.01Ω"]
        self.colorValue = NSDictionary(dictionary: colorDict)
        
        var errorDict: Dictionary = [0:"10%", 1:"5%", 2:"2%", 3:"1%", 4:"0.5%", 5:"0.25%", 6:"0.1%", 7:"0.05%"]
        self.errorValue = NSDictionary(dictionary: errorDict)
        
        //默认值
        self.resistanceErrorValue.text = "± 10%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 格总数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    // 每列的格数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0 : fallthrough
        case 1 : fallthrough
        case 2 : fallthrough
        case 3 : return 10
        default : return 7
        }
    }
    
    // 设置每行高度
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    // 设置背景颜色
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let myView = UILabel()
        
        if component == 3 {
            myView.text = self.colorValue.objectForKey(row) as? String
        } else if component == 4 {
            myView.text = self.errorValue.objectForKey(row) as? String
        } else {
            myView.text = String(row)
        }
        
        myView.textAlignment = NSTextAlignment.Center
        myView.textColor = UIColor.whiteColor()
        myView.layer.cornerRadius = 10 //设置弧度
        myView.layer.masksToBounds = true //开启圆角
        
        if component == 4 {
            switch row {
            case 1 :
                myView.backgroundColor = UIColor(red: 255, green: 210, blue: 0, alpha: 255)
            case 2 :
                myView.backgroundColor = UIColor.redColor()
            case 3 :
                myView.backgroundColor = UIColor.brownColor()
            case 4 :
                myView.backgroundColor = UIColor.greenColor()
            case 5 :
                myView.backgroundColor = UIColor.blueColor()
            case 6 :
                myView.backgroundColor = UIColor.purpleColor()
                //            case 7 :
                //                myView.backgroundColor = UIColor(red: 150, green: 149, blue: 148, alpha: 255)
            default :
                myView.backgroundColor = UIColor.grayColor()
            }
        } else {
            switch row {
            case 1 :
                myView.backgroundColor = UIColor.brownColor()
            case 2 :
                myView.backgroundColor = UIColor.redColor()
            case 3 :
                myView.backgroundColor = UIColor.orangeColor()
            case 4 :
                myView.backgroundColor = UIColor.yellowColor()
            case 5 :
                myView.backgroundColor = UIColor.greenColor()
            case 6 :
                myView.backgroundColor = UIColor.blueColor()
            case 7 :
                myView.backgroundColor = UIColor.purpleColor()
            case 8 :
                myView.backgroundColor = UIColor.grayColor()
            case 9 :
                myView.textColor = UIColor.blackColor()
                myView.backgroundColor = UIColor.whiteColor()
            default :
                myView.backgroundColor = UIColor.blackColor()
            }
        }
        
        
        return myView
    }

    // 选择后联动计算电阻
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.firstValue = row
        }
        
        if component == 1 {
            self.secondValue = row
        }
        
        if component == 2 {
            self.threeValue = row
        }
        
        if component == 3 {
            switch row {
            case 1:
                self.fourValue = 10
            case 2:
                self.fourValue = 100
            case 3:
                self.fourValue = 1_000
            case 4:
                self.fourValue = 10_000
            case 5:
                self.fourValue = 100_000
            case 6:
                self.fourValue = 1_000_000
            case 7:
                self.fourValue = 10_000_000
            case 8:
                self.fourValue = 0.1
            case 9:
                self.fourValue = 0.01
            default:
                self.fourValue = 1
            }
        }
        
        if component == 4 {
            var value = self.errorValue.objectForKey(row) as? String
            self.resistanceErrorValue.text = "± " + value!
        }
        
        self.calculation()
    }
    
    func calculation() {
        var value = Double(self.firstValue * 100 + self.secondValue * 10 + self.threeValue) * self.fourValue
        
        if value / 1_000_000 > 0.999 {
            self.finalValue = value / 1_000
            self.resistanceValue.text = String(stringInterpolationSegment: value / 1_000_000) + " MΩ"
        } else if value / 1_000 > 0.999 {
            self.finalValue = value
            self.resistanceValue.text = String(stringInterpolationSegment: value / 1_000) + " kΩ"
        } else {
            self.finalValue = value
            self.resistanceValue.text = String(stringInterpolationSegment: value) + " Ω"
        }
    }
    
}
