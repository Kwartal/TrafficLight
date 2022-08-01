//
//  Ratio.swift
//  HWTrafficLight
//
//  Created by Богдан Баринов on 29.07.2022.
//

import UIKit

extension CGFloat {
    
    func withRatio() -> CGFloat {
        self * (UIScreen.main.bounds.width / 375)
    }
    
    func withHeightRatio() -> CGFloat {
        self * (UIScreen.main.bounds.height / 812)
    }
}

extension Double {
    
    func withRatio() -> CGFloat {
        CGFloat(self) * (UIScreen.main.bounds.width / 375)
    }
    
    func withHeightRatio() -> CGFloat {
        CGFloat(self) * (UIScreen.main.bounds.height / 812)
    }
}

extension Int {
    
    func withRatio() -> CGFloat {
        CGFloat(self) * (UIScreen.main.bounds.width / 375)
    }
    
    func withHeightRatio() -> CGFloat {
        CGFloat(self) * (UIScreen.main.bounds.height / 812)
    }
}
