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
    
    var task: URLSessionDataTask?;

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
       
        
        // 加载第一个分类的菜品数据
        menuHeader.successCallBack = { [weak self]
            (model) in
            
            self?.fetchCategoryDataFromServer(menuHeaderModel: model);
        }
        
         // 更新分类内容
        menuHeader.updateCategoryDetailDataCallBack = { [weak self]
            (model) in
        
            let indexPath = IndexPath(row: 0, section: 0);
            if indexPath.row < (self?.menuModelArray.count)! {
                self?.collectionView.scrollToItem(at: indexPath, at: .top, animated: false);
            }
            
            // 请求分类数据
            self?.fetchCategoryDataFromServer(menuHeaderModel: model);
        }
    }
    
    // 请求分类数据
    private func fetchCategoryDataFromServer(menuHeaderModel: JCMenuHeaderModel) -> Void {
        
        // 取消网络请求
        task?.cancel();
        // 清空数组
        menuModelArray.removeAll();
        // 刷新UI
        collectionView.reloadData();
        // 添加加载视图
        let loadView = JCLoadDishListView();
        loadView.frame = collectionView.frame;
        self.view.addSubview(loadView);
        
        let menuViewModel = JCMenuViewModel();
        task = menuViewModel.fetchMenuDetailDataFromServer(menuHeaderModel: menuHeaderModel, successCallBack: {
            (result) in
            // 清空数组
            self.menuModelArray.removeAll();
            // 移除加载视图
            loadView.removeFromSuperview();
            // 请求成功的回调
            // 更新数组
            self.menuModelArray += result;
            // 刷新数据
            self.collectionView.reloadData();
            
            }, failureCallBack: {
                (error) in
                
                // 移除加载视图
                loadView.removeFromSuperview();
                // 请求失败后的回调
                if let error = error {
                    print(error.localizedDescription);
                
                    if error.localizedDescription == "cancelled" {
                        return;
                    } else if error.localizedDescription == "Request failed: not found (404)" {
                        // 清空数组
                        self.menuModelArray.removeAll();
                        // 刷新UI
                        self.collectionView.reloadData();
                        return;
                    }
                }
                
                // 清空数组
                self.menuModelArray.removeAll();
                // 刷新列表
                self.collectionView.reloadData();
                
                // 添加加载失败的视图
                let loadFailure = JCLoadDishListFairuleView();
                loadFailure.frame = self.collectionView.frame;
                self.view.addSubview(loadFailure);
                
                loadFailure.reloadCallBack = { [weak self, weak loadFailure]
                    _ in
                    
                    // 添加加载视图
                    let loadView = JCLoadDishListView();
                    loadView.frame = (self?.collectionView.frame)!;
                    self?.view.addSubview(loadView);
                    
                    _ = menuViewModel.fetchMenuDetailDataFromServer(menuHeaderModel: menuHeaderModel, successCallBack: { (result) in
                        
                        // 清空数组
                        self?.menuModelArray.removeAll();
                        // 移除加载视图
                        loadView.removeFromSuperview();
                        // 移除加载失败的视图
                        loadFailure?.removeFromSuperview();
                        // 拼接数据
                        self?.menuModelArray += result;
                        // 刷新UI
                        self?.collectionView.reloadData();
                        
                    }, failureCallBack: { (error) in
                        
                        // 移除加载视图
                        loadView.removeFromSuperview();
                        
                        if let error = error {
                            print(error.localizedDescription);
                        }
                        
                        // 添加加载视图
                        let loadView = JCLoadDishListView();
                        loadView.frame = (self?.collectionView.frame)!;
                        self?.view.addSubview(loadView);
                        delayCallBack(2, callBack: {
                            _ in
                            
                            loadView.removeFromSuperview();
                        });
                    })
                }
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
        if indexPath.row < menuModelArray.count {
            let model = menuModelArray[indexPath.row];
            // 处理cell交互
            handleModelUpdateUI(cell: cell, model: model);
        }
        
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
        cell.clickDishImageCallBack = { [weak cell]
            (currentModel) in
            
            guard let window = UIApplication.shared.keyWindow else {
                return;
            }
            // 此行代码是为了确保只有一个弹窗
            let tempView = window.viewWithTag(5000) as? JCDishDetailView;
            if tempView != nil {
                return;
            }
            
            // 创建详情对象
            let dishDetailView = JCDishDetailView();
            dishDetailView.tag = 5000;
            // 设置frame
            dishDetailView.frame = window.bounds;
            // 更新份数
            let resultModel = JCDishManager.findDish(model: currentModel);
            if resultModel == nil {
                currentModel.number = 0;
                dishDetailView.model = currentModel;
            } else {
                dishDetailView.model = resultModel;
            }
        
            // 添加到window上
            window.addSubview(dishDetailView);
    
            print("------------\(window.subviews.count)");
            
            // 添加弹出动画
            ZXAnimation.startAnimation(targetView: dishDetailView);
            
            // 消失按钮的回调
            dishDetailView.deleteBtnCallBack = {
                _ in
                // 从父控件中移除
                ZXAnimation.stopAnimation(targetView: dishDetailView);
            }
            
            // 添加按钮的回调
            dishDetailView.plusBtnCallBack = { [weak dishDetailView, weak cell]
                (currentModel) in
                // 份数 +1
                JCDishManager.addDish(model: currentModel);
                // 更新份数
                let resultModel = JCDishManager.findDish(model: currentModel);
                if resultModel == nil {
                    currentModel.number = 0;
                    dishDetailView?.model = currentModel;
                    cell?.model = currentModel;
                } else {
                    dishDetailView?.model = resultModel;
                    cell?.model = resultModel;
                }
                
                // 发送通知，改变份数
                NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
            }

            // 减号按钮的回调
            dishDetailView.minusBtnCallBack = { [weak dishDetailView, weak cell]
                (currentModel) in
                // 减少份数
                JCDishManager.reduceDish(model: currentModel);
                
                // 更新份数
                let resultModel = JCDishManager.findDish(model: currentModel);
                if resultModel == nil {
                    currentModel.number = 0;
                    dishDetailView?.model = currentModel;
                    cell?.model = currentModel;
                } else {
                    dishDetailView?.model = resultModel;
                    cell?.model = resultModel;
                }
                
                // 发送通知，改变份数
                NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
            }
            
            // 加入按钮的回调
            dishDetailView.addBtnCallBack = { [weak dishDetailView, weak cell]
                (currentModel) in
                
                // 改变当前模型的状态
                currentModel.isAddBtn = false;
                // 份数 +1
                JCDishManager.addDish(model: currentModel);
                // 更新份数
                let resultModel = JCDishManager.findDish(model: currentModel);
                if resultModel == nil {
                    currentModel.number = 0;
                    dishDetailView?.model = currentModel;
                    cell?.model = currentModel;
                } else {
                    dishDetailView?.model = resultModel;
                    cell?.model = resultModel;
                }
                // 发送通知，改变份数
                NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
            }
        }
        
        // 加入按钮
        cell.addBtnCallBack = { [weak cell]
            (currentModel) in
            // 改变当前模型的状态
            currentModel.isAddBtn = false;
            // 份数 +1
            JCDishManager.addDish(model: currentModel);
            
            // 更新份数
            let resultModel = JCDishManager.findDish(model: currentModel);
            if let resultModel = resultModel {
                cell?.changeNumberLabel(model: resultModel);
            } else {
                currentModel.number = 0;
                cell?.changeNumberLabel(model: currentModel);
            }
           

            // 发送通知，改变份数
            NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        }
        
        // 加号按钮
        cell.plucBtnCallBack = { [weak cell]
            (currentModel) in
            
            // 份数 +1
            JCDishManager.addDish(model: currentModel);
            
            // 更新份数
            let resultModel = JCDishManager.findDish(model: currentModel);
            if let resultModel = resultModel {
                cell?.changeNumberLabel(model: resultModel);
            } else {
                currentModel.number = 0;
                cell?.changeNumberLabel(model: currentModel);
            }
            
            // 发送通知，改变份数
            NotificationCenter.default.post(name: ChangeRedIconNumberNotification, object: nil, userInfo: nil);
        }
        
        // 减号按钮
        cell.minusBtnCallBack = { [weak cell]
            (currentModel) in
            
            // 份数 -1
            JCDishManager.reduceDish(model: currentModel);
            
            // 更新份数
            let resultModel = JCDishManager.findDish(model: currentModel);
            if let resultModel = resultModel {
                cell?.changeNumberLabel(model: resultModel);
            } else {
                currentModel.number = 0;
                cell?.changeNumberLabel(model: currentModel);
            }
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
        let menuHeaderW = width - menuHeaderX * CGFloat(2);
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
