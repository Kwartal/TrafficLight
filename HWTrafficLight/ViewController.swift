//
//  ViewController.swift
//  HWTrafficLight
//
//  Created by Богдан Баринов on 28.07.2022.
//

import UIKit
//dev test
class ViewController: UIViewController {
    
    private enum CurrentTrafficState {
        case off, red, yellow, green
    }
    
    // MARK: - Диаметр фонаря, масштабирует весь светофор
    private let lightsDiameter = 85.0.withHeightRatio()
    
    private var timerCounter = 0
    
    private var currentTrafficState: CurrentTrafficState = .off {
        didSet {
            switch currentTrafficState {
            case .off:
                trafficRedLightView.alpha = 0.3
                trafficYellowLightView.alpha = 0.3
                trafficGreenLightView.alpha = 0.3
                timerLabel.alpha = 0
            case .red:
                timerLabel.textColor = .yellow
                timerLabel.frame.origin.y = trafficRedLightView.frame.minY + 25
                UIView.animate(withDuration: 1, delay: 0) {
                    self.trafficRedLightView.alpha = 1
                    self.trafficYellowLightView.alpha = 0.3
                    self.trafficGreenLightView.alpha = 0.3
                    // FIXME: - убрать хардкод 15
                    self.timerLabel.alpha = 1
                }
            case .yellow:
                timerLabel.textColor = .green
                timerLabel.frame.origin.y = trafficYellowLightView.frame.minY + 25
                UIView.animate(withDuration: 1, delay: 0) {
                    self.trafficRedLightView.alpha = 0.3
                    self.trafficYellowLightView.alpha = 1
                    self.trafficGreenLightView.alpha = 0.3
                    self.timerLabel.alpha = 1
                }
            case .green:
                timerLabel.textColor = .yellow
                timerLabel.frame.origin.y = trafficGreenLightView.frame.minY + 25
                UIView.animate(withDuration: 1, delay: 0) {
                    self.trafficRedLightView.alpha = 0.3
                    self.trafficYellowLightView.alpha = 0.3
                    self.trafficGreenLightView.alpha = 1
                    self.timerLabel.alpha = 1
                }

            }
        }
    }
    
    private let carcassTrafficLight: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
        
    private let trafficRedLightView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0.3
        return view
    }()
    
    private let trafficYellowLightView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.alpha = 0.3
        return view
    }()
    
    private let trafficGreenLightView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.alpha = 0.3
        return view
    }()
    
    private let changeTrafficStateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 38, weight: .semibold)
        label.alpha = 0
        label.textAlignment = .center
        return label
    }()
    
    private var timer: Timer = {
        let timer = Timer()
        return timer
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "beatles")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        let blackAlphaView = UIView()
        blackAlphaView.backgroundColor = .black.withAlphaComponent(0.5)
        blackAlphaView.frame = view.frame
        view.insertSubview(blackAlphaView, at: 1)

        addSubviews()
        configureLayout()
        
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    private func addSubviews() {
        view.addSubview(carcassTrafficLight)
        view.addSubview(trafficRedLightView)
        view.addSubview(trafficYellowLightView)
        view.addSubview(trafficGreenLightView)
        view.addSubview(changeTrafficStateButton)
        view.addSubview(timerLabel)
        
        changeTrafficStateButton.addTarget(self, action: #selector(changeTrafficStateButtonDidTap(sender:)), for: .touchUpInside)
    }
        
    private func configureLayout() {
        
        /// Отступ между фонарями
        let lightsOffset = 30.0.withRatio()
        /// Ширина каркаса светофора
        let carcassTrafficLightWidth = lightsDiameter * 1.5
        /// Высота каркаса фонаря
        let carcassTrafficLightHeight = (lightsDiameter * 3.75) + (lightsOffset * 2)

        
        carcassTrafficLight.frame = CGRect(x: 0, y: 0, width: carcassTrafficLightWidth, height: carcassTrafficLightHeight)
        carcassTrafficLight.center.x = view.center.x
        carcassTrafficLight.layer.cornerRadius = carcassTrafficLightHeight * 0.16
        
        trafficRedLightView.frame = CGRect(x: 0, y: 120.withHeightRatio(), width: lightsDiameter, height: lightsDiameter)
        trafficRedLightView.center.x = view.center.x
        trafficRedLightView.layer.cornerRadius = trafficRedLightView.frame.width / 2
        
        trafficYellowLightView.frame = CGRect(x: 0, y: trafficRedLightView.frame.maxY + lightsOffset, width: lightsDiameter, height: lightsDiameter)
        trafficYellowLightView.center.x = view.center.x
        trafficYellowLightView.layer.cornerRadius = trafficRedLightView.frame.width / 2
        
        trafficGreenLightView.frame = CGRect(x: 0, y: trafficYellowLightView.frame.maxY + lightsOffset, width: lightsDiameter, height: lightsDiameter)
        trafficGreenLightView.center.x = view.center.x
        trafficGreenLightView.layer.cornerRadius = trafficYellowLightView.frame.width / 2
        
        changeTrafficStateButton.frame = CGRect(x: 0, y: trafficGreenLightView.frame.maxY + 270.withHeightRatio(), width: 120.withRatio(), height: 40.withRatio())
        changeTrafficStateButton.layer.cornerRadius = 10.withRatio()
        changeTrafficStateButton.center.x = view.center.x
        
        carcassTrafficLight.frame.origin.y = trafficRedLightView.frame.minY - lightsDiameter / 3
        setGradientLayer(view: carcassTrafficLight)
        
        timerLabel.frame = CGRect(x: 0, y: 0, width: 50.withRatio(), height: 42.withRatio())
        timerLabel.center.x = view.center.x
        
    }
    
    private func setGradientLayer(view: UIView) {
        let colorTop = UIColor().hexStringToUIColor(hex: "#0c0c0d").cgColor
        let colorBottom = UIColor().hexStringToUIColor(hex: "#636c6d").cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = view.layer.cornerRadius
                
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @objc func changeTrafficStateButtonDidTap(sender: UIButton) {
        if changeTrafficStateButton.currentTitle == "START" {
            changeTrafficStateButton.setTitle("NEXT", for: .normal)
        }

        timerCounter = 10
        timerLabel.text = "10"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        switch currentTrafficState {
        case .off:
            currentTrafficState = .red
        case .red:
            currentTrafficState = .yellow
        case .yellow:
            currentTrafficState = .green
        case .green:
            currentTrafficState = .red
        }
    }
    
    
    @objc func updateCounter() {
        //example functionality
        if timerCounter > 0 {
            timerLabel.text = "\(timerCounter)"
            timerCounter -= 1
        } else if timerCounter == 0 {
            changeTrafficStateButtonDidTap(sender: changeTrafficStateButton)
        }
    }
    
}



