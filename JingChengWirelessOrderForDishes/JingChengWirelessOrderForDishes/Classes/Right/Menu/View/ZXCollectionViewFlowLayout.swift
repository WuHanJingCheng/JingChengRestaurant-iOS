//
//  ZXCollectionViewWaterLayout.swift
//  JingChengOrderMeal
//
//  Created by zhangxu on 2016/11/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class ZXCollectionViewWaterLayout: UICollectionViewLayout {
    
    //section
    var numberOfSections = 0
    //section cell
    var numberOfCellsInSections = 0
    //row
    var rowCount = 0
    //cell 列间距
    var minimumInteritemSpacing: CGFloat = 0.0
    // 行间距
    var minimunLineitemSpacing: CGFloat = 0.0
    //cell width
    var cellHeight: CGFloat = realValue(value: 56/2);
    lazy var cellWidthArray: [CGFloat] = [CGFloat]();
    
    // 宽度的回调
    var cellWidthCallBack: ((_ indexPath: IndexPath) -> (CGFloat?))?;
    
    
    /**
     * 该方法是预加载layout, 只会被执行一次
     */
    override func prepare() {
        super.prepare()
        
        initData()
        
    }
    /**
     * 该方法返回CollectionView的ContentSize的大小
     */
    override var collectionViewContentSize: CGSize {
        var width: CGFloat = 0;
        let _ = cellWidthArray.map({
            (element) in
            width += element;
        });
        let size = CGSize(width: width, height: cellHeight);
        return size;
    }
    
    /**
     * 该方法为每个Cell绑定一个Layout属性~
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var array: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<numberOfCellsInSections {
            let indexPath = IndexPath.init(item: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexPath)
            array.append(attributes!)
        }
        return array
    }
    
    /**
     * 该方法为每个Cell绑定一个Layout属性~
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        
        var frame:CGRect = .zero
        
        var cellWidth: CGFloat = 0;
        if let cellWidthCallBack = cellWidthCallBack {
            cellWidth = cellWidthCallBack(indexPath) ?? 0;
        }
     
        let cellX: CGFloat = calculateX(indexPath: indexPath);
        let cellY: CGFloat = 0;
        let cellW: CGFloat = cellWidth;
        let cellH: CGFloat = cellHeight;
        frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH);
        // 计算每个cell的位置
        attributes.frame = frame;

        if cellWidthArray.count <= indexPath.row {
            cellWidthArray.append(cellWidth);
        }
        
        return attributes
    }
    
    // 计算x 的坐标
    func calculateX(indexPath: IndexPath) -> CGFloat {
        
        var x: CGFloat = 0;
        let _ = cellWidthArray.enumerated().map({
            (width) in
            if width.offset < indexPath.row {
                 x += width.element;
            }
        });
        return x;
    }
    
    //初始化相关数据
    func initData() -> Void {
        numberOfSections = (collectionView?.numberOfSections)!
        numberOfCellsInSections = (collectionView?.numberOfItems(inSection: 0))!
        rowCount = 1;
        minimumInteritemSpacing = realValue(value: 0);
        minimunLineitemSpacing = realValue(value: 0);
    }
    
}
