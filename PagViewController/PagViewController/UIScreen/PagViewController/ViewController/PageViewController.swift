//
//  PageViewController.swift
//  PagViewController
//
//  Created by Rath! on 30/4/24.
//

import Foundation

import UIKit



class PageViewController: UIViewController {
    
    private var currentPage = 0
    private var isTransitionInProgress = false
    private var collectionView: UICollectionView!
    private var pageController =  UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,options: nil)
    
    //MARK:  Set select items collection view first
    var controllers = [UIViewController]() // Create empty ViewController
    {
        didSet{
            DispatchQueue.main.async { [self] in
                collectionView.reloadData()
                if arrayTitleName.count > 0{
                    collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                }
            }
        }
    }
    
    //MARK: Set select pagViewController first
    var arrayTitleName = [String]()
    {
        didSet{
            DispatchQueue.main.async { [self] in
                if controllers.count > 0{
                    pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle()
        setupPageController()
    }
    
    
    private func setupTitle(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.identifier)
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupPageController(){
        //        pageController.dataSource = self
        //        pageController.delegate = self
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pageController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    
    
    
    //MARK: Rendom CGFloat
    private func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    //MARK: Rendom Color
    func randomColor() -> UIColor {
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
    }
}




extension PageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTitleName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
        cell.lblTitle.text  = arrayTitleName[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        //MARK: Protect , when didSelectItemAt fast
        if index != currentPage && index < controllers.count && !isTransitionInProgress {
            //scroll items to center
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            //set scroll pagViewContoller
            let direction: UIPageViewController.NavigationDirection = index > currentPage ? .forward : .reverse
            isTransitionInProgress = true
            pageController.setViewControllers([controllers[index]], direction: direction, animated: true) { [weak self] (completed) in
                if completed {
                    self?.currentPage = index
                }
                self?.isTransitionInProgress = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthLabel =  arrayTitleName[indexPath.item]
        //dynamic width by text
        let width = calculateLabelWidth(text: widthLabel, font: UIFont.systemFont(ofSize: 20, weight: .bold)) + 10
        return CGSize(width: width, height: 30)
    }
    
    //MARK: calculate text label width
    private func calculateLabelWidth(text: String, font: UIFont) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = font
        label.sizeToFit()
        return label.frame.width
    }
    
}




//extension PageViewController:  UIPageViewControllerDataSource, UIPageViewControllerDelegate{

//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        if let index = controllers.firstIndex(of: viewController) {
//            if index > 0 {
//                print("index ==>  \(index)" )
//                //                let lastIndex = collectionView.numberOfItems(inSection: 0)-1
//                let itemSelect = index - 1
//
//                //                if  lastIndex >= itemSelect{
//                collectionView.selectItem(at: IndexPath(item: itemSelect, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                //                }
//
//                return controllers[index - 1]
//            } else {
//                return nil
//            }
//        }
//        return nil
//    }

//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let index = controllers.firstIndex(of: viewController) {
//            if index < controllers.count - 1 {
//
//                print("index ==>  \(index)" )
//                //                let lastIndex = collectionView.numberOfItems(inSection: 0)-1
//                let itemSelect = index + 1
//
//                //                if  lastIndex >= itemSelect{
//                collectionView.selectItem(at: IndexPath(item: itemSelect, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                //                }
//
//                return controllers[index + 1]
//            } else {
//                return nil
//            }
//        }
//        return nil
//    }
//}
