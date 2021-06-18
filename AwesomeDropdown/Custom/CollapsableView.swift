//
//  CollapsableView.swift
//  AwesomeDropdown
//
//  Created by Gina Mullins on 6/15/21.
//

import UIKit
import RxSwift
import RxCocoa

class CollapsableView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var headerControl: GMControl!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var chevronImageView: UIImageView!
    @IBOutlet private weak var collapsableStackView: UIStackView!
    @IBOutlet private weak var listStackView: UIStackView!
    
    let disposeBag = DisposeBag()
    var title = BehaviorRelay<String>(value: "")
    var image = BehaviorRelay<UIImage?>(value: nil)
    var chevron = BehaviorRelay<UIImage?>(value: nil)
    var isCollapsed = BehaviorRelay<Bool>(value: true)
    
    public func configure(withStack stack: UIStackView, title: String, image: UIImage?) {
        self.title.accept(title)
        self.image.accept(image)
        for view in stack.arrangedSubviews {
            self.listStackView.addArrangedSubview(view)
        }
        print(self.listStackView.arrangedSubviews.count)
        isCollapsed.accept(true)
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("CollapsableView", owner: self, options: nil)
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
        isCollapsed
            .asDriver()
            .drive(onNext: { [weak self] collapsed in
                self?.collapsableStackView.isHidden = collapsed
                let imageName = collapsed ? "chevronRight" : "chevronDown"
                self?.chevron.accept(UIImage(named: imageName))
            })
            .disposed(by: disposeBag)
        
        headerControl.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                if let collapsed = self?.isCollapsed.value {
                    self?.isCollapsed.accept(!collapsed)
                }
            })
            .disposed(by: disposeBag)
        
        title.bind(to: headerTitleLabel.rx.text).disposed(by: disposeBag)
        image.bind(to: headerImageView.rx.image).disposed(by: disposeBag)
        chevron.bind(to: chevronImageView.rx.image).disposed(by: disposeBag)
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
