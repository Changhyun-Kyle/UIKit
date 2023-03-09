//
//  UIView+PinnedSubView.swift
//  Today
//
//  Created by 강창현 on 2023/03/09.
//

import UIKit

extension UIView {
    func addPinnedSubView(_ subview: UIView,
                          height: CGFloat? = nil,
                          insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    ) {
        addSubview(subview)
        // 자동 제약 조건 생성하지 않음. 뷰를 동적으로 배치하는 제약 조건 제공.
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true
        // subview는 superview의 상단과 하단에 고정되어 있기 때문에 subview의 높이를 조정하면 superview도 높이를 조정해야 함
        if let height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
