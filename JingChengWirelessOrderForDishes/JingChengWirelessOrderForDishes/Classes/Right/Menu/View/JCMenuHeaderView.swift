//
//  JCMenuHeaderView.swift
//  JingChengWirelessOrderForDishes
//
//  Created by zhangxu on 2016/11/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMenuHeaderView: UIView {

    // cell标识
    fileprivate let menuHeaderCellIdentifier = "menuHeaderCellIdentifier";
    
    // collectionView
    fileprivate lazy var headerCollectionView: UICollectionView = {
        let layout = ZXCollectionViewWaterLayout();
        layout.cellWidthCallBack = {
            (indexPath) -> (CGFloat?) in
            
            let model = self.menuHeaderModelArray[indexPath.row];
            var attribute = [String: Any]();
            attribute[NSFontAttributeName] = Font(size: 32/2);
            guard let MenuName = model.MenuName else {
                return 0;
            }
            
            let margin = realValue(value: 116/2 + 10/2);
            
            let width = (MenuName as NSString).size(attributes: attribute).width;
            return width + margin;
        }
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.backgroundColor = UIColor.clear;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.bounces = true;
        return collectionView;
    }();
    
    // 懒加载数组
    fileprivate lazy var menuHeaderModelArray: [JCMenuHeaderModel] = [JCMenuHeaderModel]();
    
    var updateCategoryDetailDataCallBack: ((_ model: JCMenuHeaderModel) -> ())?;
    
    // 子菜单列表加载完成的回调
    var successCallBack: ((_ model: JCMenuHeaderModel) -> ())?;
    
    deinit {
        print("JCMenuHeaderView 被释放了");
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 清除颜色
        backgroundColor = UIColor.clear;
        
        // 添加collectionView
        addSubview(headerCollectionView);
        
        // 注册cell
        headerCollectionView.register(JCMenuHeaderCell.self, forCellWithReuseIdentifier: menuHeaderCellIdentifier)
        
        let menuHeaderViewModel = JCMenuHeaderViewModel();
        menuHeaderViewModel.fetchMenuListDataFromServer(successCallBack: { (result) in
            // 清空数组
            self.menuHeaderModelArray.removeAll();
            // 请求成功
            self.menuHeaderModelArray += result;
            // 刷新数组
            self.headerCollectionView.reloadData();
            // 回调
            if self.menuHeaderModelArray.count > 0 {
                if let successCallBack = self.successCallBack {
                    successCallBack(self.menuHeaderModelArray[0]);
                }
            }
            
            }, failureCallBack: {
                (error) in
                // 请求失败
                if let error = error {
                    print(error.localizedDescription);
                }
        });
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置collectionView的frame
        headerCollectionView.frame = bounds;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 数据源方法
extension JCMenuHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 返回行
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuHeaderModelArray.count;
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuHeaderCellIdentifier, for: indexPath) as? JCMenuHeaderCell else {
            return JCMenuHeaderCell();
        };
        
        if indexPath.row < menuHeaderModelArray.count {
            
            let menuHeaderModel = menuHeaderModelArray[indexPath.row];
            cell.menuHeaderModel = menuHeaderModel;
            
            // 改变cell的状态，更新分类数据
            cell.changeOtherBtnStatusCallBack = { [weak self]
                (model) in
                
                let _ = self?.menuHeaderModelArray.enumerated().map({
                    (element) in
                    
                    element.element.isSelected = (element.element.MenuId == model.MenuId) ? true : false;
                    // 改变选中状态
                    let selectedIndexPath = IndexPath(row: element.offset, section: 0);
                    guard let cell = collectionView.cellForItem(at: selectedIndexPath) as? JCMenuHeaderCell else {
                        return;
                    }
                    // 更新选中状态
                    cell.updateSelectedStatus(model: element.element);
                    
                    // 更新分类数据
                    if let updateCategoryDetailDataCallBack = self?.updateCategoryDetailDataCallBack {
                        updateCategoryDetailDataCallBack(model);
                    }
                });
            }
        }
        
        return cell;
    }
}
