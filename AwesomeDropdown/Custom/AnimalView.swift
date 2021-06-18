//
//  AnimalView.swift
//  AwesomeDropdown
//
//  Created by Gina Mullins on 6/15/21.
//

import UIKit
import RxSwift
import RxCocoa

class AnimalView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var animalNameLabel: UILabel!
    @IBOutlet private weak var animalDescriptionLabel: UILabel!
    @IBOutlet private weak var animalImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    var animalName = BehaviorRelay<String>(value: "")
    var animalDesc = BehaviorRelay<String>(value: "")
    var image = BehaviorRelay<UIImage?>(value: nil)
    
    public func configure(withAnimal name: String, detail: String, pic: UIImage?) {
        self.animalName.accept(name)
        self.animalDesc.accept(detail)
        self.image.accept(pic)
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("AnimalView", owner: self, options: nil)
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
        animalName.bind(to: animalNameLabel.rx.text).disposed(by: disposeBag)
        animalDesc.bind(to: animalDescriptionLabel.rx.text).disposed(by: disposeBag)
        image.bind(to: animalImageView.rx.image).disposed(by: disposeBag)
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
