//
//  JCMenuController.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit
import MJRefresh

class JCMenuController: UIViewController {
    
    // cell标识
    fileprivate let menuCellIdentifier = "menuCellIdentifier";
   
    // 懒加载
    fileprivate lazy var menuHeader: JCMenuHeaderView = JCMenuHeaderView();
    
    // 懒加载collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: realValue(value: 446/2), height: realValue(value: 638/2));
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.clear;
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: realValue(value: 20/2), bottom: 0, right: realValue(value: 20/2));
        collectionView.scrollsToTop = false;
        return collectionView;
    }();
    
    // 懒加载数组
    fileprivate lazy var menuModelArray: [JCDishModel] = [JCDishModel]();

    // 释放
    deinit {
        print("JCMenuController 被释放了");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // 添加menuHeader
        view.addSubview(menuHeader);
        
        // 添加collectionView
        view.addSubview(collectionView);
        
        // 注册cell
        collectionView.register(JCMenuCell.self, forCellWithReuseIdentifier: menuCellIdentifier);
        
        // 请求肉类数据
        fetchCategoryDataFromServer(url: subMenuMeatAPI);
        
        // 更新分类内容
        menuHeader.updateCategoryDetailDataCallBack = { [weak self]
            (model) in
            // 清空数组
            self?.menuModelArray.removeAll();
            let indexPath = IndexPath(row: 0, section: 0);
            self?.collectionView.scrollToItem(at: indexPath, at: .top, animated: false);
            // 请求分类数据
            if let category_url = model.category_url {
                self?.fetchCategoryDataFromServer(url: category_url);
            }
        }
    }
    
    // 请求分类数据
    private func fetchCategoryDataFromServer(url: String) -> Void {
        
        let menuViewModel = JCMenuViewModel();
        menuViewModel.fetchMenuDetailDataFromServer(url: url, successCallBack: { [weak self]
            (result) in
            // 请求成功的回调
            // 更新数组
            self?.menuModelArray += result;
            // 刷新数据
            self?.collectionView.reloadData();
            
            }, failureCallBack: {
                (error) in
                // 请求失败后的回调
                print(error);
        })
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: - 数据源方法
extension JCMenuController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 返回行
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuModelArray.count;
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellIdentifier, for: indexPath) as? JCMenuCell else {
            return JCMenuCell();
        }
        let model = menuModelArray[indexPath.row];
        // 处理cell交互
        handleModelUpdateUI(cell: cell, model: model);
        return cell;
    }
    
    // 处理JCMenuController 返回cell的逻辑处理
    private func handleModelUpdateUI(cell: JCMenuCell, model: JCDishModel) -> Void {
        
        let resultModel = JCDishManager.findDish(model: model);
        if resultModel == nil {
            model.number = 0;
            cell.model = model;
        } else {
            cell.model = resultModel;
        }
        
        // 点击图片弹窗
        cell.clickDishImageCallBack = { [weak self]
            (currentModel) in
            
            guard let window = UIApplication.shared.keyWindow else {
                return;
            }
            let dishDetailView = JCDishDetailView();
            dishDetailView.frame = window.bounds;
            let resultModel = JCDishManager.findDish(model: currentModel);
            if resultModel == nil {
                currentModel.number = 0;
                dishDetailView.model = model;
            } else {
                dishDetailView.model = resultModel;
            }
            window.addSubview(dishDetailView);
            
            // 消失按钮的回调
            dishDetailView.deleteBtnCallBack = { [weak dishDetailView]
                _ in
                // 从父控件中移除
                dishDetailView?.removeFromSuperview();
            }
            
            // 添加按钮的回调
            dishDetailView.plusBtnCallBack = { [weak self, weak dishDetailView]
                (currentModel) in
                // 增加份数
                JCDishManager.addDish(model: currentModel);
                let resultModel = JCDishManager.findDish(model: currentModel);
                dishDetailView?.numberLabel.text = "\(resultModel?.number ?? 0)";
                // 刷新数据
                self?.collectionView.reloadData();
                // 发送通知，改变份数
                NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
            }

            // 减号按钮的回调
            dishDetailView.minusBtnCallBack = { [weak self, weak dishDetailView]
                (currentModel) in
                // 减少份数
                JCDishManager.reduceDish(model: currentModel);
                let resultModel = JCDishManager.findDish(model: currentModel);
                dishDetailView?.numberLabel.text = "\(resultModel?.number ?? 0)";
                // 隐藏加减号，显示加入按钮
                if dishDetailView?.numberLabel.text == "0" {
                    dishDetailView?.addBtn.isHidden = false;
                    dishDetailView?.plusBtn.isHidden = true;
                    dishDetailView?.numberLabel.isHidden = true;
                    dishDetailView?.minusBtn.isHidden = true;
                }
                // 刷新数据
                self?.collectionView.reloadData();
                // 发送通知，改变份数
                NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
            }
            
            // 加入按钮的回调
            dishDetailView.addBtnCallBack = { [weak self, weak dishDetailView]
                (currentModel) in
                // 显示加减号，隐藏加入按钮
                dishDetailView?.addBtn.isHidden = true;
                dishDetailView?.plusBtn.isHidden = false;
                dishDetailView?.numberLabel.isHidden = false;
                dishDetailView?.minusBtn.isHidden = false;
                // 更改份数
                JCDishManager.addDish(model: currentModel);
                let resultModel = JCDishManager.findDish(model: currentModel);
                dishDetailView?.numberLabel.text = "\(resultModel?.number ?? 0)";
                // 改变当前模型的状态
                currentModel.isAddBtn = false;
                // 刷新数据
                self?.collectionView.reloadData();
                // 发送通知，改变份数
                NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
            }
        }
        
        // 加入按钮
        cell.addBtnCallBack = { [weak self]
            (currentModel) in
            // 改变当前模型的状态
            currentModel.isAddBtn = false;
            // 份数 +1
            JCDishManager.addDish(model: currentModel);
            // 刷新状态
            self?.collectionView.reloadData();
            // 发送通知，改变份数
            NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        }
        
        // 加号按钮
        cell.plucBtnCallBack = { [weak self]
            (currentModel) in
            
            // 份数 +1
            JCDishManager.addDish(model: currentModel);
            // 刷新状态
            self?.collectionView.reloadData();
            // 发送通知，改变份数
            NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        }
        
        // 减号按钮
        cell.minusBtnCallBack = { [weak self]
            (currentModel) in
            
            // 份数 -1
            JCDishManager.reduceDish(model: currentModel);
            // 刷新状态
            self?.collectionView.reloadData();
            // 发送通知，改变份数
            NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        }
    }
}

// MARK: - 设置子控件的frame
extension JCMenuController {
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        let menuHeaderX = realValue(value: 10/2);
        let menuHeaderY = realValue(value: 20/2);
        let menuHeaderW = realValue(value: 720/2);
        let menuHeaderH = realValue(value: 56/2);
        menuHeader.frame = CGRect(x: menuHeaderX, y: menuHeaderY, width: menuHeaderW, height: menuHeaderH);
        
        
        // 设置collectionView 的frame
        let collectionViewX = realValue(value: 0);
        let collectionViewY = menuHeader.frame.maxY + realValue(value: 20/2);
        let collectionViewW = width - collectionViewX * CGFloat(2);
        let collectionViewH = height - collectionViewY;
        collectionView.frame = CGRect(x: collectionViewX, y: collectionViewY, width: collectionViewW, height: collectionViewH);
    }
}
