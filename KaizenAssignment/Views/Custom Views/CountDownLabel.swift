//
//  CountDownLabel.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 11/9/22.
//

import UIKit

final class CountDownLabel: UILabel {
    private lazy var dateFormatter = DateFormatter()
    private var timer: Timer?
    private var futureDate: Date?
    
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    func setup(with unixTime: Int) {
        futureDate = Date(timeIntervalSince1970: TimeInterval(unixTime))
    }

    func start() {
        tick()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    @objc private func tick() {
        guard let _futureDate = futureDate else { return }
        let countdown = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: _futureDate)
        let days = countdown.day!
        let hours = countdown.hour! + days * 24
        let minutes = countdown.minute!
        let seconds = countdown.second!
        guard days >= 0 && hours >= 0 && minutes >= 0 && seconds >= 0 else {
            self.text = "Game started"
            stop(); return
        }
        self.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
        
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
}
