//
//  HolidayView.swift
//  AwesomeDropdown
//
//  Created by Gina Mullins on 6/15/21.
//

import UIKit
import RxSwift
import RxCocoa

class HolidayView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var holidayNameLabel: UILabel!
    @IBOutlet private weak var holidayDateLabel: UILabel!
    @IBOutlet private weak var quickLabel: UILabel!
    @IBOutlet private weak var quickView: UIView!
    
    let disposeBag = DisposeBag()
    var holidayName = BehaviorRelay<String>(value: "")
    var holidayDate = BehaviorRelay<String>(value: "")
    var quick = BehaviorRelay<String>(value: "")
    var upcoming = BehaviorRelay<Bool>(value: false)
    
    public func configure(withHoliday name: String, date: String) {
        self.holidayName.accept(name)
        self.holidayDate.accept(date)
        showQuickView()
    }
    
    private func showQuickView() {
        // todo if next holiday is upcoming
        quick.accept("Coming Soon")
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("HolidayView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.layer.borderWidth = CGFloat(1.0)
        self.layer.borderColor = UIColor.blue.cgColor
        
        setupControls()
    }
    
    private func setupControls() {
        upcoming
            .asDriver()
            .drive(onNext: { [weak self] show in
                self?.quickView.isHidden = show
            })
            .disposed(by: disposeBag)
        
        holidayName.bind(to: holidayNameLabel.rx.text).disposed(by: disposeBag)
        holidayDate.bind(to: holidayDateLabel.rx.text).disposed(by: disposeBag)
        quick.bind(to: quickLabel.rx.text).disposed(by: disposeBag)
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

}
