//
//  ViewController.swift
//  AwesomeDropdown
//
//  Created by Gina Mullins on 6/15/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var listStackView: UIStackView!
    
    var myAnimalsCollapsable = CollapsableView()
    var holidayCollapsable = CollapsableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHolidays()
        loadAnimals()
    }
    
    private func loadHolidays() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let holiday1 = HolidayView()
        holiday1.configure(withHoliday: "Independence Day", date: "05 July")
        stackView.addArrangedSubview(holiday1)
        
        let holiday2 = HolidayView()
        holiday2.configure(withHoliday: "Labor Day", date: "06 September")
        stackView.addArrangedSubview(holiday2)
        
        let holiday3 = HolidayView()
        holiday3.configure(withHoliday: "Thanksgiving", date: "25 November")
        stackView.addArrangedSubview(holiday3)
        
        let headerImage = UIImage(named: "Reminders")
        holidayCollapsable.configure(withStack: stackView, title: "Holiday Reminders", image: headerImage)
        listStackView.addArrangedSubview(holidayCollapsable)
    }
    
    private func loadAnimals() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let animal1 = AnimalView()
        let image1 = UIImage(named: "Winry1")
        animal1.configure(withAnimal: "Winry", detail: "Waiting to play", pic: image1)
        stackView.addArrangedSubview(animal1)
        
        let animal2 = AnimalView()
        let image2 = UIImage(named: "Winry2")
        animal2.configure(withAnimal: "Winry", detail: "Ball is World", pic: image2)
        stackView.addArrangedSubview(animal2)
        
        let animal3 = AnimalView()
        let image3 = UIImage(named: "babybruce2")
        animal3.configure(withAnimal: "Baby Bruce Wayne", detail: "looks so sweet and innocent but has no concept of personal space", pic: image3)
        stackView.addArrangedSubview(animal3)
        
        let headerImage = UIImage(named: "dog")
        myAnimalsCollapsable.configure(withStack: stackView, title: "My Pets", image: headerImage)
        listStackView.addArrangedSubview(myAnimalsCollapsable)
    }


}

